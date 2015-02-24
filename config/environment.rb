# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

class String
  def numeric?
    return true if self =~ /\A\d+\Z/
    true if Float(self) rescue false
  end
end

Dir[Rails.root + 'app/models/**/*.rb'].each do |path|
  require path
end

Dir[Rails.root + 'app/google_api/**/*.rb'].each do |path|
  require path
end
