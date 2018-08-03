# frozen_string_literal: true

#
# Notification Mailer
#
class NotificationMailer < ApplicationMailer
  def notification_email
    @event = Event.find(params[:event_id])
    mail(to: @event.site.owner_email, subject: 'Monitoring notification')
  end
end
