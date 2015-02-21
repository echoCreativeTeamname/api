# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

Dir[Rails.root + 'app/models/**/*.rb'].each do |path|
  require path
end
