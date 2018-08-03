# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NotificationMailer, type: :mailer do
  before(:all) do
    @site = Site.create(name: 'Site',
                        url: 'https://sim.link',
                        owner_email: 'sirruf@me.com')
    @event = Event.create(site: @site,
                          code: 404,
                          message: 'Not found',
                          notifications_count: 1)
  end

  describe 'notify' do
    let(:mail) do
      NotificationMailer.with(event_id: @event.id)
                        .notification_email
    end

    it 'renders the headers' do
      expect(mail.subject).to eq('Monitoring notification')
      expect(mail.to).to eq(['sirruf@me.com'])
      expect(mail.from).to eq(['no-reply@res.bz'])
    end
  end
end
