server '3.114.103.126', user: 'ec2-user', roles: %w{app db web}

before_exec do |server|
  ENV["BUNDLE_GEMFILE"] = File.join(File.expand_path("../../../../", __FILE__), "current", "Gemfile")
end