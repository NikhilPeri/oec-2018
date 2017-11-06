require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "#standings returns json consumable by chartkick" do
    expected_response = [
      {
        'name'=>'Broker A',
        'data'=>[[1.hour.from_now.to_s, 1000000], [2.hours.from_now.to_s, 1200000], [3.hours.from_now.to_s, 1500000]],
      },
      {
        'name'=>'Broker B',
        'data'=>[[1.hour.from_now.to_s, 1000000], [2.hours.from_now.to_s, 1200000], [3.hours.from_now.to_s, 1500000]],
      }
    ]
    get :standings

    assert_equal 'application/json', @response.content_type
    assert_equal expected_response, JSON.parse(@response.body)
  end
end
