danfe-server
============

Brazilian DANFE generator "as a Service" (because buzzwords)

# Usage

```sh
curl -X POST http://danfe-server.herokuapp.com/ -F "file=@nota.xml" -o danfe.pdf
```
# Run locally

Install jRuby (1.7.13) and run:

```sh
jruby -S gem install bundler && jruby -S bundle install
```

Then, to run it, simply do a

```sh
jruby server.rb
```

# Performance

The lib used to generate the PDF is slow. In my machine (i5, 8Gb RAM, SSD) it
takes 8 seconds just to convert from XML to PDF (for an example NFe, some may
be faster). Heroku seems to be faster for some reason.

```
$ time ./tests/integration.sh localhost:4567
Cleaning up...
Testing against localhost:4567...
Done! Generated files:
-rw-r--r--  1 carlos  staff    30K Aug  1 01:16 ./tmp/danfe.xml.pdf
-rw-r--r--  1 carlos  staff   6.4K Aug  1 01:16 ./tmp/nfce.xml.pdf
-rw-r--r--  1 carlos  staff    24K Aug  1 01:16 ./tmp/nfe_simples_nacional.xml.pdf
-rw-r--r--  1 carlos  staff    28K Aug  1 01:16 ./tmp/nfe_with_fci.xml.pdf
-rw-r--r--  1 carlos  staff    30K Aug  1 01:16 ./tmp/nfe_with_ns.xml.pdf
-rw-r--r--  1 carlos  staff    32K Aug  1 01:16 ./tmp/nfe_without_ns.xml.pdf
./tests/integration.sh localhost:4567  0.13s user 0.04s system 1% cpu 12.616 total

$time ./tests/integration.sh
Cleaning up...
Testing against http://danfe-server.herokuapp.com...
Done! Generated files:
-rw-r--r--  1 carlos  staff    30K Aug  1 01:13 ./tmp/danfe.xml.pdf
-rw-r--r--  1 carlos  staff    30B Aug  1 01:13 ./tmp/nfce.xml.pdf
-rw-r--r--  1 carlos  staff    24K Aug  1 01:13 ./tmp/nfe_simples_nacional.xml.pdf
-rw-r--r--  1 carlos  staff    28K Aug  1 01:13 ./tmp/nfe_with_fci.xml.pdf
-rw-r--r--  1 carlos  staff    30K Aug  1 01:13 ./tmp/nfe_with_ns.xml.pdf
-rw-r--r--  1 carlos  staff    32K Aug  1 01:13 ./tmp/nfe_without_ns.xml.pdf
./tests/integration.sh  0.26s user 0.04s system 6% cpu 4.788 total
```

# Production

You can easily put this in heroku. Just create the app, add the remote and push.
