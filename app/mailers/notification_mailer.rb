# frozen_string_literal: true

#
# Notification Mailer
#
class NotificationMailer < ApplicationMailer
  def notification_email
    @event = Event.find_by(id: params[:event_id])
    mail(to: @event.site.owner_email, subject: 'Monitoring notification') if @event.present?
  end
end
