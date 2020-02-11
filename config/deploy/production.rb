server '3.114.103.126', user: 'ec2-user', roles: %w{app db web}

set :rails_env, "production"
set :unicorn_rack_env, "production"

# before_exec do |server|
#   ENV["BUNDLE_GEMFILE"] = File.join(File.expand_path("../../../../", __FILE__), "current", "Gemfile")
# end