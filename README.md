# LifehopeAttendance

[![Build Status](https://travis-ci.org/lifehopechurch/lifehope_attendance.svg?branch=master)](https://travis-ci.org/lifehopechurch/lifehope_attendance)

Application is running [here](https://lifehope-attendance.herokuapp.com/)

To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

### run migrations on heroku
```
heroku run "POOL_SIZE=2 mix ecto.migrate"
```

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
