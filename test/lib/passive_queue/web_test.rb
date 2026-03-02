require 'test_helper'
require 'rack'
require 'json'

describe PassiveQueue::Web do
  let(:web) { PassiveQueue::Web.new }

  def rack_env(path)
    Rack::MockRequest.env_for(path)
  end

  describe 'GET /' do
    it 'returns 200 with HTML' do
      status, headers, body = web.call(rack_env('/'))
      assert_equal 200, status
      assert_equal 'text/html', headers['Content-Type']
      assert_includes body[0], 'Passive Queue Dashboard'
    end
  end

  describe 'GET /api/stats' do
    it 'returns 200 with JSON' do
      status, headers, body = web.call(rack_env('/api/stats'))
      assert_equal 200, status
      assert_equal 'application/json', headers['Content-Type']
      data = JSON.parse(body[0])
      assert_equal 0, data['jobs_processed']
    end
  end

  describe 'GET /api/zen' do
    it 'returns 200 with JSON containing a quote' do
      status, headers, body = web.call(rack_env('/api/zen'))
      assert_equal 200, status
      assert_equal 'application/json', headers['Content-Type']
      data = JSON.parse(body[0])
      assert_includes PassiveQueue.zen_quotes, data['quote']
    end
  end

  describe 'GET /favicon.ico' do
    it 'returns 200 with icon content type' do
      status, headers, _body = web.call(rack_env('/favicon.ico'))
      assert_equal 200, status
      assert_equal 'image/x-icon', headers['Content-Type']
    end
  end

  describe 'GET /logo.svg' do
    it 'returns 200 with SVG content type' do
      status, headers, body = web.call(rack_env('/logo.svg'))
      assert_equal 200, status
      assert_equal 'image/svg+xml', headers['Content-Type']
      refute_empty body[0]
    end
  end

  describe 'GET /logo-dark.svg' do
    it 'returns 200 with SVG content type' do
      status, headers, body = web.call(rack_env('/logo-dark.svg'))
      assert_equal 200, status
      assert_equal 'image/svg+xml', headers['Content-Type']
      refute_empty body[0]
    end
  end

  describe 'GET /unknown' do
    it 'returns 404' do
      status, headers, body = web.call(rack_env('/unknown'))
      assert_equal 404, status
      assert_equal 'text/html', headers['Content-Type']
      assert_includes body[0], '404'
    end
  end
end
