unless Rails.env.production?
  ENV['NIXUS_WEB_DATABASE_PASSWORD'] = "b1a3050401"
end
