class AddConfirmableToDevise < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :confirmation_token, :string
    add_column :users, :confirmed_at, :datetime
    add_column :users, :confirmation_sent_at, :datetime
    add_index :users, :confirmation_token, unique: true
    add_column :users, :unconfirmed_email, :string
    User.update_all confirmed_at: DateTime.now
    # All existing user accounts should be able to log in after this.
  end
end
