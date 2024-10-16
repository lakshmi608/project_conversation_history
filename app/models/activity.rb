class Activity < ApplicationRecord
  belongs_to :user
  belongs_to :project
  belongs_to :trackable, polymorphic: true

  validates :action, presence: true
end
