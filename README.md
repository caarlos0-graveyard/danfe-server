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
takes 8 seconds just to convert from XML to PDF.
