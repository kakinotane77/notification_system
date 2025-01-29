class Customer < ApplicationRecord
  validates :name, presence: true
  validates :phone, presence: true, if: -> { email.blank? }
  validates :email, presence: true, if: -> { phone.blank? }
end
