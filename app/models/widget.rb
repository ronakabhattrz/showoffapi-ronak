class Widget < ApplicationRecord
	has_many :user_widgets
	has_many :users, through: :user_widgets
end
