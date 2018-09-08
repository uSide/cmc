# NODE
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
apt-get install -y build-essential nodejs

# UTILS
apt-get install -y htop git-core libssl-dev python-software-properties software-properties-common libpq-dev autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev
echo "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main" > /etc/apt/sources.list.d/pgdg.list
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
apt-get update
apt-get install -y postgresql-client-common postgresql-client-10

# RUBY
wget http://ftp.ruby-lang.org/pub/ruby/2.5/ruby-2.5.1.tar.gz
tar -xzvf ruby-2.5.1.tar.gz
cd ruby-2.5.1/ && ./configure && make && sudo make install
sudo gem install bundler