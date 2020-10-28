# NEW: Docker

## Docker Setup

`docker build -t rails .`

`docker run -it -p 3000:3000 rails`

## Run tests
`docker build -t rails .`

`docker run rails rake test`

# Endpoints
## All questions

`localhost:3000/questions?tenant_id=<TENANT_ID>&api_key=<API_KEY>`


## One auestion

`localhost:3000/question/<QUESTION_ID>?tenant_id=<TENANT_ID>&api_key=<API_KEY>`

## Dashboard

`localhost:3000/dashboard`
![image](https://user-images.githubusercontent.com/148787/97469620-997bcd80-1914-11eb-8151-405dd0795aec.png)


## Project Setup

Clone this repo locally, and from the top-level directory run:

`bundle install`

`bundle exec rake db:setup`

To make sure it's all working,

`rails s`
