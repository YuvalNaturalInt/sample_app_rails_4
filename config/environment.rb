# Load the rails application.
require File.expand_path('../application', __FILE__)

# Initialize the rails application.
SampleApp::Application.initialize!

NIConfig[:domain_name] = 'Demo'