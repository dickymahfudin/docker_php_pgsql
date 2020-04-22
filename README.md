## Installation
  - `mkdir myapp`  
  - `cd myapp`
  - `git clone https://github.com/dickymahfudin/docker_php_pgsql.git docker`
  - `mkdir app`
  - `cd docker`
  - `docker-compose -d up --build`
 
## Installation Laravel
  - `docker-compose exec php bash`
  - `git clone `https://github.com/dickymahfudin/isnoc.git `.`
  - `composer install`
  - `cp .env.example .env`
  - `php artisan key:generate`
  
## DB
  ```sh
      POSTGRES_USER: "docker"
      POSTGRES_PASSWORD: "docker"
      POSTGRES_DB: "docker"
  ```
  
  - http://localhost:8088
  