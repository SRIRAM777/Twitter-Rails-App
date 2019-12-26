class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :followed_by_id
    end
    add_index :relationships, :follower_id
    add_index :relationships, :followed_by_id
    add_index :relationships, [:follower_id, :followed_by_id], unique: true
  end
end
