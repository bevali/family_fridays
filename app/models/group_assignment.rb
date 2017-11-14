class GroupAssignment < ActiveRecord::Base
	belongs_to :user
	validates :group, uniqueness: { scope: [:user] }
end
