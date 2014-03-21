# Compass
###

# Susy grids in Compass
# First: gem install susy
# require 'susy'

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

page 'robots.txt', layout: false
page 'humans.txt', layout: false
page 'sitemap.xml', layout: false

# Proxy (fake) files
# page "/this-page-has-no-template.html", :proxy => "/template-file.html" do
#   @which_fake_page = "Rendering a fake page with a variable"
# end

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

helpers do
  def nav_link(name, url, opts={})
    opts[:class] = 'current' if current?(url)
    link_to(name, url, opts)
  end

  def current?(url)
    exact_url = url_for(url)
    base_path = File.dirname(exact_url)
    base_file = File.basename(exact_url, '.*')
    path = Pathname.new(base_path + File::SEPARATOR + base_file).cleanpath.to_s
    path == '/' ? current_resource.url == path : current_resource.url.start_with?(path)
  end
end

set :css_dir, 'styles'

set :js_dir, 'scripts'

set :images_dir, 'images'

# Enable live reload while working locally
activate :livereload

# set :relative_links, true

# Build-specific configuration
#
configure :build do

  # For example, change the Compass output styles for deployment
  activate :minify_css
  activate :minify_javascript

  # Enable cache buster
  activate :cache_buster

  # Use relative URLs
  # activate :relative_assets

  # Compress PNGs after build
  # activate :smusher

  # Build with nice urls
  activate :directory_indexes

end

activate :s3_sync do |s3_sync|
  s3_sync.bucket = 'www.freiaemtersagenweg.ch'
  s3_sync.region = 'eu-west-1'
end
