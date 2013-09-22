require 'test/unit'
require 'rgba-png'

if ENV['RUBYMINE']
  require 'minitest/reporters'
  MiniTest::Reporters.use!
end

class RgbaPngTest < Test::Unit::TestCase

  def test_create_file_name_from_color_hash
    color = {r: 255, g: 200, b: 100, a:128}

    assert_equal "255-200-100-0_5", RgbaPng.color_name(color)
  end

end