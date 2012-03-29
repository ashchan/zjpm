require_relative 'test_helper'

class MatterTest < MiniTest::Unit::TestCase
  include Rack::Test::Methods

  def test_new_instance
    assert_kind_of Matter, Matter.new
  end

  def test_aqi_calculation
    [
      [0,     0],   [15.4,  50],
      [15.5,  51],  [35.4,  100],
      [35.5,  101], [65.4,  150],
      [65.5,  151], [150.4, 200],
      [150.5, 201], [250.4, 300],
      [250.5, 301], [350.4, 400],
      [350.5, 401], [500.4, 500]
    ].each do |m|
      assert_equal m.last, Matter::aqi(m.first).first
    end
  end
end
