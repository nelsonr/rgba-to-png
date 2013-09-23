require "oily_png"

class RgbaPng

  def self.init(file, destination)
    if !file || !destination
      puts 'Error: wrong number of arguments, expected 2'
      puts 'Usage: rgba-png sourcefile destination'

      return
    end

    colors = parse(file)
    create_files colors, destination

    puts colors.uniq.length.to_s + ' image(s) created!'
  end

  # Creates colors array from source file
  def self.parse(file)
    colors = []
    rgba = /rgba\((\d+),(\d+),(\d+),(\d?.\d+)\)/

    IO.foreach(file) do |line|
      is_rgba = line.match rgba

      if is_rgba
        color = {
            r: is_rgba[1].to_i,
            g: is_rgba[2].to_i,
            b: is_rgba[3].to_i,
            a: (is_rgba[4].to_f * 255).to_i # Convert alpha value to 0-255 range
        }

        colors.push(color)
      end
    end

    colors
  end

  # Create file name from color, ex: 255-255-255-0.8
  def self.file_name(color)
    # Convert the alpha to 0-1 range
    alpha = (color[:a] / 255.to_f).round(1)

    color[:r].to_s + '-' + color[:g].to_s + '-' + color[:b].to_s + '-' + alpha.to_s
  end

  # Create png files from colors
  def self.create_files(colors, destination)
    colors.uniq.each do |color|
      bg = ChunkyPNG::Color.rgba(color[:r], color[:g], color[:b], color[:a])
      png = ChunkyPNG::Image.new(16, 16, bg)

      unless Dir.exists? destination
        Dir.mkdir destination
      end

      png.save(destination + '/' + (file_name(color) + '.png'), interlace: true)
    end
  end

end