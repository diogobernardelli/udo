<img src="https://i.ibb.co/mNZNqcD/logo.png" style="height: 80px;" />
<br />

*Create tasks for **You** to **do*** 

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
$ gem install bundle
$ bundle
$ touch config/database.yml
```

This last command will create a new file. Copy the content from the `database-sample.yml` file to the `database.yml` and then update with your `postgresql` username and password credentials.

After that, you are able to create the database and start the server:

```bash
$ rails db:create db:migrate
$ rails s
```
It should be running on `http://localhost:3000`

Also, it will be required to start redis server:
```bash
$ redis-server
```

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


## Major Features

| Feature |  |
| --- | --- |
| Sign in | ✓ |
| Sign up | ✓ |
| Create Activity | ✓ |
| Update Activity | ✓ |
| Reorder Activity | ✓ |
| Delete Activity | ✓ |
| Visual Callbacks (success & errors) | ✓ |
| Turn on/off Notifications | ✓ |



## About the design

I came with the **UDo** (acronym to You Do) name while was thinking about a good to-do list name. Then, after searching for inspiration to create a logo, I [found this](https://www.behance.net/gallery/102541371/UDo) and I was never able to thinking in something <span style="text-decoration: line-through;">better</span> else than this incredible design.

[Rafa Dantas](https://www.behance.net/rafadantas) is the real deal!
