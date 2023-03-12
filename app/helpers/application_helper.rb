module ApplicationHelper
  def user_avatar(user)
    if user.avatar?
      url_for user.avatar.variant(resize_to_fill: [400, 400])
    else
      asset_path("user.png")
    end
  end

  def user_avatar_thumb(user)
    if user.avatar.attached?
      url_for user.avatar.variant(:thumb)
    else
      asset_path("user.png")
    end
  end

  def event_photo(event)
    photos = event.photos.persisted

    if photos.any?
      url_for photos.sample.photo.variant(:thumb)
    else
      asset_path("event_thumb2.jpg")
    end
  end

  def event_thumb(event)
    photos = event.photos.persisted

    if photos.any?
      photos.sample.photo.url
    else
      asset_path("event_thumb.jpg")
    end
  end

  def fa_icon(icon_class)
    content_tag "span", "", class: "fa fa-#{icon_class}"
  end

  def bs_icon(name)
    case
    when name == :google_oauth2
      "<i class=\"bi bi-google\"></i>".html_safe
    when name == :github
      "<i class=\"bi bi-github\"></i>".html_safe
    when name == :facebook
      "<i class=\"bi bi-facebook\"></i>".html_safe
    end
  end
end
