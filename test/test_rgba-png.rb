require 'test/unit'
require 'rgba-png'
require 'fileutils'

if ENV['RUBYMINE']
  require 'minitest/reporters'
  MiniTest::Reporters.use!
end

class RgbaPngTest < Test::Unit::TestCase

  def teardown
    new_folder = File.dirname(__FILE__) + '/i-dont-exist-yet'
    path = File.dirname(__FILE__) + '/images/'
    file = '255-200-100-0.5.png'

    if File.exists?(path + file)
      File.delete(path + file)
    end

    if Dir.exists?(new_folder)
      FileUtils.rm_r new_folder
    end
  end

  def test_create_destination_folder_if_not_exists
    colors = [{r: 255, g: 200, b: 100, a:128}]
    destination = File.dirname(__FILE__) + '/i-dont-exist-yet'

    RgbaPng.create_files(colors, destination)

    assert_equal true, Dir.exists?(destination)
  end

  def test_create_file_from_color_hash_array
    colors = [{r: 255, g: 200, b: 100, a:128}]
    destination = File.dirname(__FILE__) + '/images'

    RgbaPng.create_files(colors, destination)

    assert_equal true, File.exists?(destination + '/255-200-100-0.5.png')
  end

  def test_create_file_name_from_color_hash
    color = {r: 255, g: 200, b: 100, a:128}
    assert_equal "255-200-100-0.5", RgbaPng.file_name(color)
  end

  def test_parse_source_file_should_create_hash_array
    source_file = File.dirname(__FILE__) + '/test-style.css'

    expected = [
        {r: 255, g: 200, b: 254, a: 76},
        {r: 0, g: 200, b: 70, a: 127},
        {r: 255, g: 120, b: 10, a: 204}
    ]

    assert_equal expected, RgbaPng.parse(source_file)
  end

end