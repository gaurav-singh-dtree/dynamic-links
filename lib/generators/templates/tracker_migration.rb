class CreateTrackersTable < ActiveRecord::Migration[6.0]
  def change
    create_table :dynamic_links_tracker do |t|
      t.belongs_to :dynamic_links_dynamic_link
      t.string :user_agent
      t.string :ip
      t.string :remote_ip
      t.string :http_origin
      t.string :http_origin
      t.string :http_request
      t.text   :query_parameters

      t.timestamps
    end
  end
end