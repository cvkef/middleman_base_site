require 'uglifier'

###########################
# Slim Template Engine
###########################
require 'slim'
set :slim, pretty: true


###########################
# Browser Auto-Reload
###########################
activate :livereload


###########################
# Bower
###########################
activate :bower


###########################
# Localization
###########################
activate :i18n, langs: [:en]
I18n.enforce_available_locales = false


###########################
# Assets Directories
###########################
set :css_dir,     'stylesheets'
set :js_dir,      'javascripts'
set :images_dir,  'images'


###########################
# Pretty URLs
###########################
activate :directory_indexes
set :index_file, 'index.html'


###########################
# Relative URLs
###########################
set :relative_links, true


###########################
# Pages without Layout
###########################
# page 'page.html', layout: false


###########################
# Single Pages with Alternative Layout
###########################
# page '/path/to/page.html', layout: :my_layout


###########################
# Group of Pages with Alternative Layout
###########################
# with_layout :admin do
#   page "/admin/*"
# end


###########################
# Environment
###########################
#set :environment, :build


###########################
# Build Configuration
###########################
configure :build do
  # Generate Favicon from source/favicon_base.png
  activate :favicon_maker

  # Use Relative Assets
  activate :relative_assets

  # Enable cache buster     Cache Method #01
  # activate :cache_buster

  # Enable Cache Buster     Cache Method #02
  activate :asset_hash

  # Minify HTML
  activate :minify_html

  # Minify CSS
  activate :minify_css

  # Minify JS
  activate :minify_javascript, compressor: Uglifier.new

  # GZip
  activate :gzip
end


###########################
# Deploy Configuration :: FTP
###########################
# activate :deploy do |deploy|
#   deploy.method     = :ftp
#   deploy.host       = 'ftp-host'
#   deploy.user       = 'ftp-user'
#   deploy.password   = 'ftp-password'
#   deploy.path       = 'ftp-path'
# end


###########################
# Helpers
###########################
helpers do

  # Page Title
  def page_title(title = '')
    title = I18n.t title, default: "#{title}"
    title != '' ? "#{title} | #{data.general.website.name}" : data.general.website.name
  end

  # Active Menu Item
  def current_menu(page)
    'active' if @page_id == page
  end

  # Home Page
  def homepage?
    @page_id == '/' || @page_id == 'index.html'
  end

end