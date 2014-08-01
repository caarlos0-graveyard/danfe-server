danfe-server
============

Brazilian DANFE generator "as a Service" (because buzzwords)

Usage (**really** slow):

```sh
curl -X POST http://danfe-server.herokuapp.com/ -F "file=@nota.xml" -o danfe.pdf
```
