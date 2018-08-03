# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Site, type: :model do
  context 'check' do
    it 'should return true if success' do
      site = Site.create(name: 'Ccrrect site',
                         url: 'https://sim.link',
                         owner_email: 'ask-home@yandex.ru')
      expect(site.check).to eq(true)
    end
    it 'should return false if url is incorrect' do
      site = Site.create(name: 'Ccrrect site',
                         url: 'aldkjas',
                         owner_email: 'ask-home@yandex.ru')
      expect(site.check).to eq(false)
    end
  end
end
