When writing upstart scripts using `expect daemon` or `export fork` you may eventually find yourself with a hung process.

I ran into this issue with my `redis-server` script and it looked like the following:

```
redis-server stop/killed, process 18113
```

If you see the `stop/killed, process ...` status you're shit out of luck. There's a lot of discussion about this problem, but no good solutions.  You've basically got three options:

1) Restart the server
2) Duplicate the script but use a different name (just let the old one hang itself)
3) Run a script like `resque.rb` (included) to exhaust the process ids until it wraps around to the hung process and then kills it