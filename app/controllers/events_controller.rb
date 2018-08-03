class EventsController < ApplicationController
  before_action :set_site

  def index
    @events = @site.events
  end

  private

  def set_site
    @site = Site.find(params[:site_id])
  end

end