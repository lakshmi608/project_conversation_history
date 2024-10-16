class Project < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :status_changes, dependent: :destroy
  has_many :activities, dependent: :destroy

  validates :status, presence: true
end
