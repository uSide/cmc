class ApplicationController
  class Context < OpenStruct
    include R18n::Helpers

    def partial(filename, context)
      ApplicationController.slim(filename, Context.new(context))
    end

    def number_to_currency(num)
      format('%.2f', num)
        .gsub('.00', '')
        .reverse
        .scan(/(\d*\.\d{1,3}|\d{1,3})/)
        .join(',')
        .reverse
    end

    def time_ago(timestamp)
      delta = Time.now.to_i - timestamp
      case delta
      when 0..59 then t.time_ago.now
      when 60..3599 then t.time_ago.minutes((delta / 60).round)
      when 3600..86_399 then t.time_ago.hours((delta / 3600).round)
      when 86_400..259_199 then t.time_ago.days((delta / 86_400).round)
      else Time.at(timestamp).strftime('%d %B %Y %H:%M')
      end
    end
  end

  def initialize(env)
    @request = Rack::Request.new(env)
    R18n.set('en')
    R18n.set('ru') if params.key?('ru')
  end

  class << self
    def slim(filename, context = Context.new)
      template = File.join(File.dirname(__FILE__), '/../views',
                           "#{filename}.slim")
      Slim::Template.new(template).render(context)
    end

    def json(data)
      Oj.dump(data, mode: :strict)
    end
  end

  private

  def params
    @request.params
  end

  def body
    @body ||= Oj.load(@request.body.read, mode: :strict,
                                          allow_blank: false,
                                          quirks_mode: false)
    @body
  rescue Oj::ParseError
    {}
  end

  protected

  def render(input)
    response = if input.key?(:html)
                 ApplicationController.slim(input[:html],
                                            Context.new(input[:context]))
               else
                 ApplicationController.json(input[:json])
               end

    [200, {}, response]
  end
end
