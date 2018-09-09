# Setup
- Install dependencies using `bundle install`
- Create .env.development and .env.test based on .env.example
- Run migrations
```shell
sequel -m db/migrations postgres://host/database
```
# Usage
```shell
rackup # start web server on port defined in env file
rake # daemon that fetches data from coinmarketcap
```
#### Database reset
```shell
sequel -m db/migrations -M 0 postgres://host/database
sequel -m db/migrations postgres://host/database
```
