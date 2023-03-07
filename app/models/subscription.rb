class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  validates :user_name, presence: true, unless: -> { user.present? }
  validates :user_email, presence: true, format: /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/, unless: -> { user.present? }

  validates :user, uniqueness: { scope: :event_id }, if: -> { user.present? }

  validates :user_email, uniqueness: { scope: :event_id }, unless: -> { user.present? }
  validate :email_already_taken, unless: -> { user.present? }
  validate :ban_yourself_subscription

  def user_name
    if user.present?
      user.name
    else
      super
    end
  end

  def user_email
    if user.present?
      user.email
    else
      super
    end
  end

  def email_already_taken
    errors.add(:base, :taken) unless User.find_by(email: user_email).nil?
  end

  def ban_yourself_subscription
    errors.add(:base, :self_subscription) if user == event.user
  end
end
