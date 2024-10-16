class StatusChange < ApplicationRecord
  belongs_to :user
  belongs_to :project
  has_one :activity, as: :trackable, dependent: :destroy

  after_create :create_activity

  validates :previous_status, :new_status, presence: true

  private

  def create_activity
    Activity.create!(
      user: user,
      project: project,
      action: 'status_changed',
      trackable: self
    )
  end
end
