# Heroku-Refinery

This repository should allow you to create a set of container-based Refinery dynos in your Heroku environment.

NOTE: If you're not using Heroku Enterprise and Private Spaces, you will not be able to scale to multiple Refinery nodes in your cluster.

## Prep Steps

Create your Heroku App:

```bash
heroku apps:create <REFINERY_APP_NAME> -t <HEROKU_TEAM_NAME>
```

Set the stack type to `container`:

```bash
heroku stack:set container
```

Add the heroku-redis addon. You should not need more than the hobby-dev resources:

```bash
heroku addons:create heroku-redis:hobby-dev --wait
```

Set the config value to allow Refinery to send logs and metrics to your team:

```bash
heroku config:set HC_API_KEY=<HONEYCOMB_API_KEY>
```

Set the PORT config value. It should match the standard HTTP_PORT for Refinery (8080):

```bash
heroku config:set PORT=8080
```

Set the config value to enable Dry Run Mode. By default, Dry Run is disabled, and sampling will happen:

```bash
heroku config:set DRY_RUN=<DRY_RUN> 
```

Set the config values for listening ports if you do not want to use the Refinery standard listening ports:

```bash
heroku config:set HTTP_PORT=<REFINERY_HTTP_PORT>
heroku config:set GRPC_PORT=<REFINERY_GRPC_PORT>
heroku config:set PEER_PORT=<REFINERY_PEER_PORT>
```

Update the `rules.toml` file to match the rules you want to use in your sampling.

## Launch Your Refinery Application

Once you've got your environment set, and your rules are good, you should be able to commit your code and push to heroku.

```bash
git commit -am "prepped for heroku deployment"
git push heroku main
```

Once the build completes, you can see the status of your nodes using `heroku ps`.

To scale up your Refinery instances, you can run the following:

```bash
heroku ps:scale web:3
```

where `3` is the number of Refinery nodes you want to have
