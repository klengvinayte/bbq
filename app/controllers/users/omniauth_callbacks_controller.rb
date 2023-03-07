class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    user = User.find_for_oauth(request.env["omniauth.auth"])
    signin_and_redirect(user, "Github")
  end

  def facebook
    @user = User.find_for_oauth(request.env["omniauth.auth"])
    signin_and_redirect(@user, "Facebook")
  end

  def google_oauth2
    @user = User.find_for_oauth(request.env["omniauth.auth"])
    signin_and_redirect(@user, "Google")
  end

  def signin_and_redirect(user, provider)

    if user.persisted?
      flash[:notice] = I18n.t("devise.omniauth_callbacks.success", kind: "#{provider}")
      sign_in_and_redirect user, event: :authentication
    else
      flash[:error] = I18n.t(
        "devise.omniauth_callbacks.failure",
        kind: "#{provider}",
        reason: "authentication error"
      )

      redirect_to root_path
    end
  end
end
