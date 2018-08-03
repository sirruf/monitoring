# frozen_string_literal: true

#
# Sites Controller
#
class SitesController < ApplicationController
  before_action :set_site, only: [:edit, :update, :destroy]

  def index
    @sites = Site.all
  end

  def new
    @site = Site.new
  end

  def create
    @site = Site.new(site_params)
    if @site.save
      redirect_to sites_path
    end
  end

  def update
      if @site.update(site_params)
        redirect_to sites_path
      else
        render :edit
      end
  end

  def destroy
    @site.destroy
    redirect_to sites_path
  end

  private

  def site_params
    params.require(:site).permit(:name, :url, :owner_email)
  end

  def set_site
    @site = Site.find(params[:id])
  end
end
