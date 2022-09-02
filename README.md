# recipes

## Table of Contents

- [Requirements](##requirements)
- [Initialization](##initialization)
- [Setup](##setup)
- [Deployment](##deployment)
- [Supplement](##supplement)
- [Endpoints](##endpoints)

## Requirements

- Docker 19.x
  If you run the project locally, the followings are required.
- Ruby 3.0.0
- Bundler 2.1.x
- Node.js 14.15.1
- Yarn 1.22.x
- MySQL 8.0.x

## Setup

Setup procedure of development environment.
Run `cp env.example .env` and open `.env` file to edit environment variables.

### Docker environment

Build docker containers

```bash
docker-compose build
```

Initialize

```bash
docker-compose run web ruby ./bin/initialize
```

Setup database

```bash
docker-compose run web bundle exec rake db:create db:migrate db:seed
```

Start the app

```bash
docker-compose up
```

### Local environment

Install dependencies

````bash
## Install gems
bundle install
Start mysql and setup database
```bash
bin/rake db:create db:migrate db:seed
````

Start the app

```bash
## API server
bin/rails s
```

Start console

```bash
bin/rails c
```

## Deployment

Once you created the staging and production environments in Jitera's DevOps menu, you can deploy to staging by pushing a new commit to `develop` branch, and to production by pushing a new commit to `master` branch.

## Supplement

This project was generated by jitera automation, run by Jitera.

## Endpoints

1. `GET /api/recipes` - Search recipes by title, by time range, and by difficulty. Query parameters are the following.
    - `title` - title of the recipe
    - `min_time` and `max_time` - time range in seconds
    - `difficulty` - difficulty as an integer (0 is easy, 1 is normal, 2 is challenging)

    - sample usage
      - `GET http://localhost:3000/api/recipes?title=cheese&min_time=1200&max_time=3600&difficulty=1`
      - will search and return recipes that
        - have the substring cheese in their title,
        - can be done from 20 minutes to 1 hour, and
        - are normal in terms of difficulty

2. `POST /api/conversions` - Convert units from one to the others.
    - sample request body
    ```
    {
      "from_value": 2,
      "from_unit": "kg",
      "to_unit": "g"
    }
    ```
    - units supported are the following
      - weight: "kg" and "g"
      - volume: "c" and "tsp"
      - to support other units would be as simple as updating the Measurement::MULTIPLIERS constant

3. `POST /api/recipes/:recipe_id/ratings` - Rate a recipe.
    - sample request body
    ```
    {
      "score": 5,
      "comment": "excellent"
    }
    ```
    - score can be any integer from 1 to 5 (star rating system)
    - comment is optional
    - a user can rate a recipe only once (but can update or delete the rating)

4. `GET /api/recipes/:recipe_id/ratings` - Get the ratings and the user who gave it.
    - no query parameters
    - no request body
