class AddDeletedAtToCreditcard < ActiveRecord::Migration
  def change
    add_column :creditcards, :deleted_at, :datetime
  end
end
