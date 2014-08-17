danfe-server
============

Brazilian DANFE generator "as a Service" (because buzzwords)

# API Usage

```sh
$ curl -X POST host -F "file=@nota.xml" -o danfe.pdf
```
# Run locally

Install jRuby (1.7.13) and run:

```sh
$ jruby -S gem install bundler && jruby -S bundle install
```

Then, to run it, simply run:

```sh
$ foreman start -f Procfile.dev
```

> Note: this will also start the `redis-server` process.

Or, in production:

```sh
$ RACK_ENV=production foreman start
```

# Performance

In my machine, it usually takes around 10 seconds to generate this 6 DANFEs:

```
$ time ./tests/integration.sh localhost:5000
Cleaning up...
Testing against localhost:5000...
Done! Generated files:
-rw-r--r--  1 carlos  staff    30K Aug 17 13:29 ./tmp/danfe.xml.pdf
-rw-r--r--  1 carlos  staff   2.4K Aug 17 13:29 ./tmp/nfce.xml.pdf
-rw-r--r--  1 carlos  staff    24K Aug 17 13:29 ./tmp/nfe_simples_nacional.xml.pdf
-rw-r--r--  1 carlos  staff    28K Aug 17 13:29 ./tmp/nfe_with_fci.xml.pdf
-rw-r--r--  1 carlos  staff    30K Aug 17 13:29 ./tmp/nfe_with_ns.xml.pdf
-rw-r--r--  1 carlos  staff    32K Aug 17 13:29 ./tmp/nfe_without_ns.xml.pdf
./tests/integration.sh localhost:5000  0.21s user 0.05s system 2% cpu 8.442 total
```

# Production

You can easily put this in heroku. Since last version, we use Redis to store
statistics about the server usage. So, first, add the Redis2Go addon:

```sh
$ heroku addons:add redistogo
```

Then, alias the `REDISTOGO_URL` to `REDIS_URL`:

```sh
$ heroku config:set REDIS_URL=$(heroku config:get REDISTOGO_URL)
```

Now, push and have fun!
