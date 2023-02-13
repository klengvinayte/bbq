class SubscribersNotificationJob < ApplicationJob
  queue_as :default

  def perform(record, mail = nil)
    if record.class == Photo || record.class == Comment
      all_emails =
        (record.event.subscriptions.map(&:user_email) + [record.event.user.email] - [record.user&.email])
    end

    case record
    when Subscription
      EventMailer.subscription(record, record.user.email).deliver_later
    when Photo
      all_emails.each { |email| EventMailer.photo(record, email).deliver_later }
    when Comment
      all_emails.each { |email| EventMailer.comment(record, email).deliver_later }
    end
  end
end


