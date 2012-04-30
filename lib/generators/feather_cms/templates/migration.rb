class CreateFeatherPages < ActiveRecord::Migration
  def change
    create_table :feather_pages do |t|
      t.string :name
      t.string :status, :default => 'draft'
      <% if @storaage == 'db' %>
        t.text   :content
      <% end %>
      t.string :layout, :default => 'application'
      t.timestamps
    end
  end
end
