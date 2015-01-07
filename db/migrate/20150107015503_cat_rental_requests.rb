class CatRentalRequests < ActiveRecord::Migration
  def change
    change_column :cat_rental_requests, :status, :string, :null => true

  end
end
