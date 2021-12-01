# README

## Float Junior Software Developer Take Home Test

**Written by James Torkornoo** **github:@mrtorks**

---
Things you may want to cover:

* Ruby version 3.0.0

* Rails 6.1.4

---
System dependencies

* MacOS/Linux preferrably. Any system configured with ruby and rails should work
* Redis installed and running

---
Configuration

  1. Ensure **Ruby** and **rails** are installed
  2. Run

        ```ruby
        bundle install
        ```

  3. Have **Homebrew** install redis
  4. Run command below for MacOS/Linus or start redis on your preferred system

        ```bash
        brew services start redis
        ```

---
Database creation

* Not needed as active record is not used

---

* How to run the test suite
  * **For Requests**
    1. Ping

        ```ruby
        rspec spec/requests/ping_spec.rb 
        ```

    2. Posts

        ```ruby
        rspec spec/requests/posts_spec.rb 
        ```

---

* **For Routes**
    1. Ping

        ```ruby
        rspec spec/routing/ping_routing_spec.rb
        ```

    2. Posts

        ``` ruby
        rspec spec/routing/posts_routing_spec.rb 
        ```

---

* **For Class Method Errors**
    1. Posts

    ```ruby
    rspec spec/models/post_spec.rb
    ```

---

* Test if Rails cache is working

```ruby
2.times.map { Rails.cache.fetch("test", expires_in: 1) { rand } }.uniq.length == 1
```

---

* Nice to use Postman/Insomnia to test API
  * GET (posts) url example =

    ```url
    http://<your-url>/api/posts?tags=tech&direction=desc
    ```

     ```url
    http://<your-url>/api/posts?tags=tech,health,culture,politics&direction=desc
    ```

     ```url
    http://<your-url>/api/posts?tags=tech,health,culture,politics&sortBy=reads&direction=desc
    ```
