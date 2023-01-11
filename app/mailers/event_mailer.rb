class EventMailer < ApplicationMailer

  def subscription(event, subscription)
    @email = subscription.user_email
    @name = subscription.user_name
    @event = subscription.event

    mail to: event.user.email, subject: "Новая подписка на #{event.title}"
  end

  def comment(event, comment, email)
    @comment = comment
    @event = comment.event

    mail to: email, subject: "Новый комментарий от #{@event.title}"
  end

  def photo(photo, email)
    @event = photo.event
    @photo = photo

    mail to: email, subject: "Новое фото добавлено в #{@event.title}"
  end
end
