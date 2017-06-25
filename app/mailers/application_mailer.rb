# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@techtreino.com'
  layout 'mailer'
end
