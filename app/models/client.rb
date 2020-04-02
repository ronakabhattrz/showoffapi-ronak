class Client < ApplicationRecord
	validates :client_id, :client_secret, presence: true
	validates :client_id, uniqueness: true
	validates :client_secret, uniqueness: true
end
