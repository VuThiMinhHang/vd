class Book < ActiveRecord::Base
	belongs_to :user
	default_scope -> { order('created_at DESC') }
	validates :name, presence: true, length: { maximum: 50}
	validates :description, presence: true, length: { maximum: 500}
  	validates :user_id, presence: true
end
