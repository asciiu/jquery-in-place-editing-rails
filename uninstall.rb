# Uninstall hook code here
puts "Removing files..."
dir = "javascripts"
["jquery.in_place_editing.js"].each do |js_file|
  # /public/javascripts/[js_file]
	src_file = File.join(RAILS_ROOT, "public", dir, js_file)
	# remove the file
	FileUtils.rm_rf(src_file)
end

# remove the example image
img_file = File.join(RAILS_ROOT, "public", "images", "leaf.png")
FileUtils.rm_rf(img_file)

puts "Files removed - Uninstallation complete!"