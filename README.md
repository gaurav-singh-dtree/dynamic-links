# Dynamic Links
Motivation for this gem comes from the requirement that sometimes rails applications needs to customize the links which they send for the campaigns or share on the social networking platforms.
This gem provides following features - 
 - Url shortening
 - Custom Urls
 - Append tracking params to the Dynnamic Urls(This gem will generate the custom url for the campaigns but when the url will be redirected, it will be appended with the utm params which will help in tracking the url)
 - Expire the dynamic url

## Installation
There are 3 steps required for using this gem in rails application - 
- ## Add gem to the gemfile
```
  # gem for the dynamic links  
  gem 'dynamic_links'  
```

  Then run `bundle install`   
- ## Add routes to the `routes.rb ` file
```
  # mount the gem engine  
  mount DynamicLinks::Engine => "/dynamic_links"  
  # route to manage the redirect from the dynamic links  
  get "#{DynamicLinks.configuration.root}/:id" => "dynamic_links/dynamic_links#send_to"  
```

- ## Import the gem  
  One of the best practice to use the gem is to add the `require 'dynamic_links'` to one of the initializers in the `app/config/initializer` folder and configure the gem according the applciations requirement
  ```
  # Inside the initializer file
  require 'dynamic_links'
  DynamicLinks.configure do |config|
    config.forbidden_keywords << "noluck"
    config.root = "dm"
    config.default_expiry = Date.today >> 3
    config.sublink_length = 5
    config.hash_salt = SecureRandom.hex
  end
  ```
- ## Migration  
    First we need to generate the migration file which contains the details of the dynamic links. 
    ```
      bundle exec rails generate dynamic_links
    ```
    This will generate a migration file in the `app/db/migrate` folder.  
    Now run the migration to generate the table in the database  
    ```
    bundle exec rails db:migration
    ```


## Configuration
```
DynamicLinks.configure do |config|
  config.forbidden_keywords << "noluck"
  config.root = "dm"
  config.default_expiry = Date.today >> 3
  config.sublink_length = 5
  config.hash_salt = SecureRandom.hex
end
```
- *forbidden_keywords* - This configuration is used for the appending the words which should not be included in the the dynamic link.
- *root* - This is used for the root of the dynamic link. All the dynamic links are prefixed with this root path.
- *default_expiry* - While generating the dynamic link if we don't explicitly assign the expiry date then this date will be assigned for the default link expiry.
- *sublink_length* - All dynamic links are suffixed with a unique key.
- *hash_salt* - For security of unique id of the dynamic links

## Usage
We can use following template to generate the dynamic link in the simplest way - 
```ruby
:001 > DynamicLinks::DynamicLink.generate(hostname: "http://www.test.com", options: {link: "/tests/22"})
=> "http://www.test.com/dm/AnXxn"
```
Please refer wiki for the detail explanations of the parameters and their usage in the generator.


## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
