require "oily_png"

class RgbaPng

  @colors = []
  @rgba = /rgba\((\d+),(\d+),(\d+),(\d?.\d+)\)/

  def self.parse(file, location)
    if !file || !location
      puts 'Error: wrong number of arguments, expected 2'
      puts 'Usage: rgba-png sourcefile destination'

      return
    end

    location = location + '/'

    IO.foreach(file) do |line|
      is_rgba = line.match @rgba

      if is_rgba
        color = {
            r: is_rgba[1].to_i,
            g: is_rgba[2].to_i,
            b: is_rgba[3].to_i,
            a: (is_rgba[4].to_f * 255).to_i # Convert alpha value to 0-255 range
        }

        @colors.push(color)
      end
    end

    create_files @colors, location

    puts @colors.uniq.length.to_s + ' file(s) created!'
  end

  # Create file name from the color, ex: 255-255-255-0_8
  def self.color_name(color)
    # Convert the alpha back to the 0-1 range and substitute the '.' for a '_'
    alpha = (color[:a] / 255.to_f).round(1).to_s.sub('.', '_')
    color[:r].to_s + '-' + color[:g].to_s + '-' + color[:b].to_s + '-' + alpha
  end

  def self.create_files(colors, location)
    colors.uniq.each do |color|
      bg = ChunkyPNG::Color.rgba(color[:r], color[:g], color[:b], color[:a])
      png = ChunkyPNG::Image.new(16, 16, bg)
      png.save(location + (self.color_name(color) + '.png'), interlace: true)
    end
  end

end