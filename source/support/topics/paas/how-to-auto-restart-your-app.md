There are a few different stopgaps you might consider implementing to automatically restart an app after it crashes.

1. One lightweight method that is framework-agnostic is to just wrap your service definitions in a bash `while` loop. Your Procfile might look like:

  ```bash
  web: while true; do bundle exec rails server; sleep 1; done
  ```

  or

  ```bash
  web: while true; do node app.js; sleep 1; done
  ```

2. If you're using Rails, you might consider a process monitoring tool like [God](http://godrb.com/) to start your Rails server, instead of starting it directly.  For example, if you're running `bundle exec rails server` to launch your server, you could use the following `god.rb` (committed to the top level of your repo):

  ```ruby
   God.watch do |w|
     w.name = 'rails'
     w.start = 'bundle exec rails server'
     w.keepalive
   end
  ```

  Your Procfile would be:

  ```bash
  web: god -c god.rb -D
  ```

3. A similar approach for Node apps is to use the `forever` [package](https://www.npmjs.com/package/forever), and including the following line in your Procfile:

  ```bash
  web: forever app.js
  ```
