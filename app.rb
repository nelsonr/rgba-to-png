require "oily_png"

if ARGV.length != 2 
	puts 'Error: Wrong number of arguments!'
	puts 'Command usage is: "app.rb path_to_source_file images_destination"'
	abort()
end

file = ARGV[0].to_s
location = ARGV[1].to_s + '/'
colors = []
rgba = /rgba\((\d+),(\d+),(\d+),(\d?.\d+)\)/

# Create file name from the color, ex: 255-255-255-0_8
def color_name(color)
	# convert the alpha back to the 0-1 range and substitute the '.' for a '_'
	alpha = (color[:a] / 255.to_f).round(1).to_s.sub('.', '_')
	color[:r].to_s + '-' + color[:g].to_s + '-' + color[:b].to_s + '-' + alpha
end

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

colors.uniq.each do |color|
	bg = ChunkyPNG::Color.rgba(color[:r], color[:g], color[:b], color[:a])
	png = ChunkyPNG::Image.new(16,16, bg) # 16px by 16px
	png.save(location + (color_name(color) + '.png'), interlace: true)
end