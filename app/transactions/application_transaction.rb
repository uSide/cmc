class ApplicationTransaction
  include Dry::Transaction

  class InvokeError < RuntimeError
    attr_reader :failure

    def initialize(failure = nil)
      @failure = failure
      super
    end
  end

  class << self
    # rubocop:disable Metrics/MethodLength
    def perform(arguments = {}) # rubocop:disable Metrics/AbcSize
      start = Time.now

      begin
        result = new.call(arguments)
      rescue InvokeError => exception
        result = exception.failure
      end

      return result if ENV.fetch('APP_ENV') == 'test'

      total = ((Time.now - start).to_f * 1000).to_i

      msg = if result.success?
              Rainbow("#{name} finished in #{total} ms").blue
            else
              Rainbow("#{name} failed (#{result.failure}) in #{total} ms").red
            end

      puts msg.bright
      result
    end
    # rubocop:enable Metrics/MethodLength

    def expects(&block)
      define_method(:validate) do |input|
        schema = Dry::Validation.Schema(&block)
        result = schema.call(input)
        return Success(result.output) if result.success?
        Failure(result.messages)
      end

      step :validate
    end
  end

  private

  def invoke(transaction, arguments = {})
    result = transaction.perform(arguments)
    return result if result.success?
    raise InvokeError, result
  end
end
