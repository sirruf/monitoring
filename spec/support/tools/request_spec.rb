# frozen_string_literal: true

require 'rails_helper'

describe Tools::HTTPRequest do
  it 'should return error if url is incorrect' do
    incorrect_url = 'incorrect_url'
    expect { Tools::HTTPRequest.check(incorrect_url) }
      .to raise_error(RuntimeError, 'Incorrect URL')
  end
  it 'should return 200 if url is correct' do
    correct_url = 'https://sim.link'
    response = Tools::HTTPRequest.check(correct_url)
    expect(response[:code]).to eq(200)
    expect(response[:message]).to eq('OK')
  end
  it 'should return 301 if url is correct' do
    correct_url = 'http://sim.link'
    response = Tools::HTTPRequest.check(correct_url)
    expect(response[:code]).to eq(301)
    expect(response[:message]).to eq('Moved Permanently')
  end
  it 'should return 999 if url is just like correct' do
    correct_url = 'http://sim.links'
    response = Tools::HTTPRequest.check(correct_url)
    expect(response[:code]).to eq(999)
    correct_response = 'Failed to open TCP'
    expect(response[:message]).to include(correct_response)
  end
end
