Gem::Specification.new do |s|
  s.name    = "activerecord-db-tasks"
  s.version = "0.0.2"
  s.summary = "Rake db tasks for ActiveRecord sans Rails"

  s.authors     = ["Gabe Smith"]
  s.email       = ["sgt.floydpepper@gmail.com"]
  s.date        = Time.now.strftime "%Y-%m-%d"
  s.homepage    = "https://github.com/sgtFloyd/activerecord-db-tasks"
  s.description = "Rake db managements tasks for projects that use ActiveRecord without Rails."

  s.require_paths = ["lib"]
  s.files         = Dir['lib/**/*.rb']

  s.add_dependency "activerecord"
end
