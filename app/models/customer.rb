class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :addresses
  has_many :cart_items
  has_many :orders

  def customer_address_display
    "〒" + postal_code + '' + address + '' + name_display
  end

  def name_display
    first_name + last_name
  end
end
