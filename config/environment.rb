# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

# TODO: Rewrite this

Dir[Rails.root + 'app/google_api/**/*.rb'].each do |path|
  require path
end
