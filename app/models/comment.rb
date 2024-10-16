class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :project
  has_one :activity, as: :trackable, dependent: :destroy

  after_create :create_activity

  validates :content, presence: true

  private

  def create_activity
    Activity.create!(
      user: user,
      project: project,
      action: 'commented',
      trackable: self
    )
  end
end
