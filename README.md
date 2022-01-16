# chat syste,.
## Built with
- Rails
- Redis 
- docker
- sidekiq
- mysql
- phpmyadmin
- kibana and elasticsearch




## Prerequisites
  1. docker
  2. docker-compose https://docs.docker.com/engine/install/ubuntu/
## Installation Steps
- clone the repo
- API
 ```sh
docker-compose up -d
```
- Test cases 
```sh
cd api
docker-compose exec chat_system_app_1  sidekiq
```

- Test cases 
```sh
cd api
docker-compose exec chat_system_app_1  bundle exec rspec
```
## Browse URLs
| Service | URL |
| ------ | ------ |
| Api | http://localhost:3001/v1 |
| kibana | http://localhost:5601 |
| phpmyAdmin | http://localhost:7001/ user:root password:password |

## Postman
- import the collection and enviroment



