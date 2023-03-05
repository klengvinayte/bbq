require "open-uri"

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[github facebook google_oauth2]

  has_many :events, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy

  validates :name, presence: true, length: { maximum: 35 }

  before_validation :set_name, on: :create

  after_commit :link_subscriptions, on: :create

  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_fit: [100, 100]
  end

  def self.find_for_oauth(access_token)
    # debugger
    # We get the email from the token
    email = access_token.info.email
    user = where(email: email).first
    avatar_url = access_token.info.image

    # We return it if found
    return user if user.present?

    # If not found, we get the provider, ID and URL
    provider = access_token.provider

    case provider
    when "github"
      id = access_token.extra.raw_info.url
      url = "https://github.com/#{id}"
      name = access_token.info.name
    when "facebook"
      id = access_token.extra.raw_info.id
      url = "https://facebook.com/#{id}"
      name = access_token.extra.raw_info.name
    when "google_oauth2"
      url = "google/#{email}"
      name = access_token.info.name
    end

    # Now we are looking for a record in the database by provider and URL
    # If there is, it will return, if not, a new one will be created
    where(url: url, provider: provider).first_or_create! do |user|
      # If we create a new record, we prescribe an email and password
      user.email = email
      user.name = name
      user.password = Devise.friendly_token.first(16)
      user.avatar.attach(io: URI.open("#{avatar_url}"), filename: "name_avatar") if avatar_url.present?
    end
  end

  private

  def set_name
    self.name = "User №#{rand(777)}" if self.name.blank?
  end

  def link_subscriptions
    Subscription.where(user_id: nil, user_email: self.email).update_all(user_id: self.id)
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end
end
