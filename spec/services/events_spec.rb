# frozen_string_literal: true

require 'rails_helper'

describe Events do
  before(:all) do
    @site = Site.create(name: 'Site',
                        url: 'https://sim.link',
                        owner_email: 'sirruf@me.com')
    @result = { code: 404, message: 'Not found' }
  end

  it 'should create new event' do
    Events.create_or_update(@site, @result)
    expect(@site.events.unresolved.count).to eq(1)
    expect(@site.events.unresolved.last.code).to eq(@result[:code])
    result = { code: 500, message: 'Error' }
    Events.create_or_update(@site, result)
    expect(@site.events.unresolved.count).to eq(1)
    expect(@site.events.unresolved.last.code).to eq(@result[:code])
  end
end
