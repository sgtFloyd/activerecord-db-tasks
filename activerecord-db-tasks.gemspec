Gem::Specification.new do |s|
  s.name    = "activerecord-db-tasks"
  s.version = "0.0.1"
  s.summary = "Rake db tasks for ActiveRecord sans Rails"

  s.authors     = ["Gabe Smith"]
  s.email       = ["sgt.floydpepper@gmail.com"]
  s.date        = Time.now.strftime "%Y-%m-%d"
  s.homepage    = "https://github.com/sgtFloyd/activerecord-db-tasks"
  s.description = "activerecord-db-tasks provides rake db tasks for ActiveRecord without Rails"

  s.require_paths = ["lib"]
  s.files         = Dir['lib/**/*.rb']

  s.add_dependency "activerecord"
end
