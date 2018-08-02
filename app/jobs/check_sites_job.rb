# frozen_string_literal: true

#
# Site Checking Job
#
class CheckSitesJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    Site.active.each(&:check)
  end
end
