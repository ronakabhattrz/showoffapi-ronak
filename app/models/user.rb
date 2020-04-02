class User < ApplicationRecord
	has_secure_password
	validates :email, :first_name, :last_name, :image_url, presence: true
	validates :email, uniqueness: true
	has_many :user_widgets
	has_many :widgets, through: :user_widgets
end
