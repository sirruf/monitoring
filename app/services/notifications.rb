# frozen_string_literal: true

#
# Notification Class
#
class Notifications
  MINUTES = [3, 10, 50, 100, 500].freeze
  def initialize(event)
    @event = event
  end

  def send
    @event.increment!(:notifications_count) if notification_needed?
  end

  def self.send(event)
    new(event).send
  end

  private

  def notification_needed?
    min = minutes_ago
    MINUTES.map.with_index do |more_than, notification_count|
      minutes_in_range(min, more_than, notification_count)
    end.include?(true)
  end

  def minutes_in_range(min, more_than, notification_count)
    min > more_than && @event.notifications_count == notification_count
  end

  def minutes_ago
    time_diff = (Time.current - @event.created_at)
    (time_diff / 1.minute).round
  end
end
