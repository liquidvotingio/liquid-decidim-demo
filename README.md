# decidim-instance

Free Open-Source participatory democracy, citizen participation and open government for cities and organizations

This is the open-source repository for decidim-instance, based on [Decidim](https://github.com/decidim/decidim).

## Setting up the application

This setup instruction assumes you've installed the appropriate `ruby` and `postgres`, and cloned this repository to your local workspace. 

This is a generated Decidim application, configured with `decidim-proposals` and `decidim-liquidvoting` modules. There is no need to run "decidim decidim-instance" or another version of the generator; this repo has already done that work for you.

You will also need a local copy of [the decidim-liquidvoting module](https://github.com/liquidvotingio/decidim-liquidvoting), which should be located at "../decidim-liquidvoting", per the `Gemfile`.

Finally you will need to install the gems with `bundle install`.

### Databases

All relevant database migrations for the enabled decidim gems/modules have already been copied into `db/migrate`; those two things should normally be in sync, and you won't need the migration installers.

However, you will need to create a database and seed the data:

```ruby
> export DATABASE_USERNAME=postgres
> bundle exec rails db:setup
```

If you already have `decidim-instance_development` and/or `decidim-instance_test` databases, to avoid schema and migration version conflicts, it may be simplest to recreate them:
```ruby
> export DATABASE_USERNAME=postgres
> bundle exec rails db:reset
```

Both of these cases will create a database and load the seed data; there is no need to do further migrations unless you extend the database with additional decidim modules.

### Users

You will need at least a System Admin, a System, and a normal User.

The seeded data includes at least one of each, `system@example.org`, `admin@example.org`, and `user@example.org` respectively, all authenticated with `decidim123456`.

If you wish to create your own System Admin:

1. Open a Rails console in the server: `bundle exec rails console`
2. Create a System Admin user:
```ruby
> user = Decidim::System::Admin.new(email: <email>, password: <password>, password_confirmation: <password>)
> user.save!
```

### Organizations

An Organization is included in the seed data, but if you wish to create your own:

1. Visit `<your app url>/system` and login with your system admin credentials
2. Create a new organization. Check the locales you want to use for that organization, and select a default locale.
3. Set the correct default host for the organization, otherwise the app will not work properly. Note that you need to include any subdomain you might be using.
4. Fill the rest of the form and submit it.

You're good to go!

### Running locally, with local liquidvoting API instance

For development, when running a Decidim instance locally with this module bundled, if you want to also run an API instance locally, you'll need to export the following env vars before starting Decidim:

```bash
export LIQUID_VOTING_API_URL="http://localhost:4000" 
export LIQUID_VOTING_API_ORG_ID="24e173f5-d99a-4470-b1cc-142b392df10a"
sudo -E bin/rails s --port=80
```

Notes:

We use `sudo` so we can override port 80 - The API doesn't accept proposal urls with ports. The `-E` option so it'll remember the environment variables exported.

For instructions on how to setup the API locally, [see the API repo's README](https://github.com/liquidvotingio/api#local-setup)
