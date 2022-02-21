class CreateDynamicLinksTable < ActiveRecord::Migration[6.0]
    def change
      create_table :dynamic_links_dynamic_links do |t|
        # the unique key
        t.string :link_key, null: false
        t.string :hostname, null: false
        t.text   :link_data
        t.string :about
        t.boolean :active, default: true
  
        # valid until date for expirable urls
        t.datetime :expires_at
  
        t.timestamps
      end
    end
  end
  