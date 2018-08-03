# frozen_string_literal: true

#
# Application Mailer
#
class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@res.bz'
  layout 'mailer'
end
