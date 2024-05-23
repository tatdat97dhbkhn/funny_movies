## Introduction

The website helps people share interesting YouTube videos with each other

- [Prerequisites](#prerequisites)
- [Installation & Configuration](#installation--configuration)
- [Database Setup](#database-setup)
- [Running the Application](#running-the-application)
- [Running Worker](#running-worker)
- [Access](#access)
- [Usage](#usage)
- [Testing](#testing)


### Prerequisites

- [Docker](https://www.docker.com/)

### Installation & Configuration

- Clone project: `git clone git@github.com:tatdat97dhbkhn/funny_movies.git`
- `chmod +x entrypoint_development.sh`
- Config ENV: `cp .env.example .env`
- Build project: `make build`

### Database Setup

- `make db-setup`

### Running the Application

- `make dev && make debug`

### Running Worker

- `make sidekiq`

### Access

- [http://localhost:3000/](http://localhost:3000/)

### Usage

- Users can watch videos shared by others without logging in
- If you want to share videos, you must register an account
- After registering an account, you log in to the system and start sharing videos with everyone

### Testing

- `make rspec`
