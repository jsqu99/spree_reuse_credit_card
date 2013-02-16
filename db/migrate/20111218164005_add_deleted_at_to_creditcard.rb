class AddDeletedAtToCreditcard < ActiveRecord::Migration
  def change
    add_column :spree_creditcards, :deleted_at, :datetime
    add_index :spree_creditcards, :deleted_at
  end
end
