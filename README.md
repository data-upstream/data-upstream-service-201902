# README

## setup

### For development
  
```brew install postresql```  
```brew services start postresql```  
  
Add a database for development  
```psql postgres```  
```CREATE DATABASE "dataupstream_development";```  
```CREATE ROLE dataupstream LOGIN PASSWORD 'dataupstream';```  
```GRANT ALL PRIVILEGES ON DATABASE dataupstream_development TO dataupstream;```  
  
By default, the RAILS_ENV is set to 'development'  
```export RAILS_ENV=development```  
```bin/rake db:migrate```  
```bin/rails s```  
  
### For production
  
Below are the generic steps to setup production:  
1. Create a secret key unique to your machine (or server)  
```RAILS_ENV=production rake secret```  
2. Create and configure your database settings (similar to the step for development database above). Currently, the settings are hard-coded in database.yml, you may configure it with some local env variables.  
3. You may create an environment file to be sourced locally (of course, this can be set once in the server). Below is mine for reference.  
```
#!/bin/bash

export RAILS_ENV=production
export SECRET_KEY_BASE=<secret key from step 1>
export PORT=<some port>
export CORS_ORIGIN=<some address>
export POSTGRES_USER=<...>
export POSTGRES_PASSWORD=<...>
```
4. Source this file  
```source <your file>```
5. Migrate your production database  
```rails db:migrate```
6. Set the eager_load in production.rb to false, else you will get uninitialized constant error.    
This is one small nuisance, refer to here for details: https://github.com/rails/spring/issues/519  
```config.eager_load = false```
7. Start the server  
```rails s```
8. You may access the server from ```<your machine address:port>```  
If it's local, then ```http://localhost:<port>```

see the doc in .... [todo]

* (j)Ruby version

See the .ruby-version file in repo.

* System dependencies

* software developers

### testing

* testing

./bin/bundle install

./bin/bundle exec rspec

### interface with jupyter

pip install jupyter
cd APP_DIR/python-notebooks
jupyter

get the notebooks from: ...... [todo]

### [todo]

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

