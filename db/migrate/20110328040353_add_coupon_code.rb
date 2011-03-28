class AddCouponCode < ActiveRecord::Migration
  def self.up
    add_column :signups, :coupon_code, :string
  end

  def self.down
    remove_column :signups, :coupon_code
  end
end
