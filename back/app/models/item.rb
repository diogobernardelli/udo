class Item < ApplicationRecord
	belongs_to :user
	
	validates :title, :order, presence: true
end
