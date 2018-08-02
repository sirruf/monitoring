# frozen_string_literal: true

#
# Events Updater
#
class Events
  def initialize(site, check_result)
    @site = site
    @check_result = check_result
  end

  def create_or_update
    last_event = unresolved_event
    if last_event.present?
      last_event.update_attributes(solved: check_success?,
                                   updated_at: Time.now)
    else
      last_event = Event.new(@check_result)
      @site.events << last_event unless check_success?
    end
    last_event
  end

  def self.create_or_update(site, check_result)
    new(site, check_result).create_or_update
  end

  private

  def mark_as_solved
    @site.unresolved_for_site.update_all(solved: true)
  end

  def check_success?
    @check_result[:code] == 200
  end

  def unresolved_event
    @site.events.unresolved.last
  end
end
