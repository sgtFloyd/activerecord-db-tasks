require 'active_record'
require 'yaml'

db_namespace = namespace :db do
  task :environment do
    @db_config = YAML.load_file('config/database.yml')
    @version = ENV["VERSION"] ? ENV["VERSION"].to_i : nil
    @step = ENV['STEP'] ? ENV['STEP'].to_i : 1
  end

  task :establish_connection => :environment do
    ActiveRecord::Base.establish_connection @db_config
  end

  desc 'Create the database in config/database.yml'
  task :create => :environment do
    ActiveRecord::Base.establish_connection @db_config.merge('database' => nil)
    ActiveRecord::Base.connection.create_database @db_config['database']
    db_namespace[:establish_connection].invoke
  end

  desc 'Drops the database in config/database.yml'
  task :drop => :environment do
    ActiveRecord::Base.establish_connection @db_config.merge('database' => nil)
    ActiveRecord::Base.connection.drop_database @db_config['database']
  end

  desc "Migrate the database (target specific version with VERSION=x)."
  task :migrate => :establish_connection do
    ActiveRecord::Migration.verbose = true
    ActiveRecord::Migrator.migrate ActiveRecord::Migrator.migrations_paths, @version
  end

  namespace :migrate do
    desc 'Runs the "up" for a given migration VERSION.'
    task :up => :establish_connection do
      raise 'VERSION is required' unless @version
      ActiveRecord::Migrator.run :up, ActiveRecord::Migrator.migrations_paths, @version
    end

    desc 'Runs the "down" for a given migration VERSION.'
    task :down => :establish_connection do
      raise 'VERSION is required' unless @version
      ActiveRecord::Migrator.run :down, ActiveRecord::Migrator.migrations_paths, @version
    end

    desc 'Rollback the database one migration and re migrate up (options: STEP=x, VERSION=x).'
    task :redo => :environment do
      if @version
        db_namespace['migrate:down'].invoke
        db_namespace['migrate:up'].invoke
      else
        db_namespace['rollback'].invoke
        db_namespace['migrate'].invoke
      end
    end
  end

  desc 'Resets your database using your migrations.'
  task :reset => ['db:drop', 'db:create', 'db:migrate']

  desc 'Rolls the schema back to the previous version (specify steps w/ STEP=n).'
  task :rollback => :establish_connection do
    ActiveRecord::Migrator.rollback ActiveRecord::Migrator.migrations_paths, @step
  end

  desc 'Pushes the schema to the next version (specify steps w/ STEP=n).'
  task :forward => :establish_connection do
    ActiveRecord::Migrator.forward ActiveRecord::Migrator.migrations_paths, @step
  end

  desc "Retrieves the current schema version number."
  task :version => :establish_connection do
    puts "Current version: #{ActiveRecord::Migrator.current_version}"
  end
end
