Gyazz
=====
Read/write Gyazz data

- https://github.com/masui/gyazz-ruby
- https://rubygems.org/gems/gyazz


Installation
------------

    % gem install gyazz


Usage
-----

read/write data at http://gyazz.com/test/aaa

```ruby
require 'gyazz'

wiki = Gyazz.wiki('test')
page = wiki.page('aaa')

# read page
puts page.text

# write page
page.text = ["Toshiyuki Masui", "masui@pitecan.com", "....."]

# URL
puts page.url  ## => "http://gyazz.com/test/aaa"
```

```ruby
# page list
wiki.pages.each do |page|
  puts "- #{page.name}"
end

# related pages
Gyazz.wiki('test').page('aaa').related_pages.each do |page|
  puts "-> #{page.name}"
end
```

read/write data at http://your-private-gyazz.com/wiki_name/page_name

```ruby
wiki = Gyazz.wiki('wiki_name')
wiki.host = 'http://your-private-gyazz.com'
wiki.auth = {:username => 'user', :password => 'pass'}
puts wiki.page('page_name').text
```


Test
----

    % gem install bundler
    % bundle install
    % bundle exec rake test

test with local gyazz

    % GYAZZ_HOST="http://localhost:3000" bundle exec rake test


Contributing
------------
1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
