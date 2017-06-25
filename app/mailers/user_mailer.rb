# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def welcome(user)
    @user = user
    @reset_password_url = "#{ENV['CLIENT_URL']}/forgot"
    mail(to: @user.email, subject: I18n.t('user_mailer.welcome.subject'))
  end
end
