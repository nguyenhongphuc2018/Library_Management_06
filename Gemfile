source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "acts_as_follower", github: "tcocca/acts_as_follower"
gem "acts_as_votable", "~> 0.11.1"
gem "bootstrap", "~> 4.1.1"
gem "bootstrap4-kaminari-views"
gem "carrierwave", "1.2.2"
gem "coffee-rails", "~> 4.2"
gem "config", "~> 1.7.0"
gem "devise"
gem "devise-bootstrap-views"
gem "ffaker", "~> 2.9.0"
gem "figaro", "~> 1.1", ">= 1.1.1"
gem "font-awesome-rails"
gem "whenever", require: false
gem "i18n-js"
gem "jbuilder", "~> 2.5"
gem "jquery-rails"
gem "kaminari"
gem "mysql2"
gem "puma", "~> 3.7"
gem "rails", "~> 5.1.6"
gem "ransack"
gem "rubocop", "~> 0.54.0", require: false
gem "sass-rails", "~> 5.0"
gem "social-share-button"
gem "toastr-rails"
gem "turbolinks", "~> 5"
gem "uglifier", ">= 1.3.0"
gem "rolify"
gem "cancancan", "~> 2.0"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "capybara", "~> 2.13"
  gem "selenium-webdriver"
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
