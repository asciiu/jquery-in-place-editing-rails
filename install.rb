# Install hook code here
puts "Copying files..."
dir = "javascripts"
["jquery.in_place_editing.js"].each do |js_file|
	dest_file = File.join(RAILS_ROOT, "public", dir, js_file)
	src_file = File.join(File.dirname(__FILE__) , dir, js_file)
	FileUtils.cp_r(src_file, dest_file)
end

# copy the example image
dest_file = File.join(RAILS_ROOT, "public", "images", "leaf.png")
src_file = File.join(File.dirname(__FILE__), "images","leaf.png")
FileUtils.cp_r(src_file, dest_file)

puts "Files copied - Installation complete!"