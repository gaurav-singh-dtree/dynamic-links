class CreateDynamicLinksTable < ActiveRecord::Migration
    def change
      create_table :dynamic_links do |t|
  
        # the real url that we will redirect to
        t.text :url, null: false, length: 2083
  
        # the unique key
        t.string :unique_key, limit: 10, null: false
  
        # a category to help categorize shortened urls
        t.string :category
  
        # how many times the link has been clicked
        t.integer :use_count, null: false, default: 0
  
        # valid until date for expirable urls
        t.datetime :expires_at
  
        t.timestamps
      end
    end
  end