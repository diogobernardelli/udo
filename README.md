# uDo

**uDo** - Create tasks for **you** to **do** :)

IMAGEM VAI AQUI

## About the project

This is a so called **To Do List**, created using Ruby on Rails (backend) + Vue (frontend) - the very productive modern stack with minimal boilerplate code and elegant conventions that allow implementation of business logic with a very few lines of code. The less code, the more readable it is, the easier it is to change and maintain it.


## - SETUP

### BACK

- Ruby v2.6.3
	- If you have not installed Ruby on your machine, we recommend using  [RVM](https://rvm.io/) to install it.
- Rails v5.2.6
- psql (PostgreSQL) v9.3.5

To setup the API project, run the following commands:
```bash
$ cd back/
$ bundle
$ rails db:create db:migrate
$ rails s
```

It will be also required to start redis server:
```bash
$ redis-server
```

It should be running on `http://localhost:3000`

### FRONT

- @vue/cli 4.5.10
- npm 7.13.0

To setup the Front-end project, run the following commands:
```bash
$ cd front/
$ npm install
$ npm run serve
```

It should be running on `http://localhost:8080`