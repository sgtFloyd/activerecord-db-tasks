activerecord-db-tasks
=====================
Rake db tasks for ActiveRecord projects sans Rails.  
`rake db:create`, `rake db:migrate`, etc.

Usage
-----
**Install the gem:** `gem install activerecord-db-tasks`  
**Include it in your Rakefile:** `require 'activerecord-db/tasks'`

Tasks
-----
```bash
rake db:create        # Create the database in config/database.yml
rake db:drop          # Drops the database in config/database.yml
rake db:forward       # Pushes the schema to the next version (specify steps w/ STEP=n).
rake db:migrate       # Migrate the database (target specific version with VERSION=x).
rake db:migrate:down  # Runs the "down" for a given migration VERSION.
rake db:migrate:redo  # Rollback the database one migration and re migrate up (options: STEP=x, VERSION=x).
rake db:migrate:up    # Runs the "up" for a given migration VERSION.
rake db:reset         # Resets your database using your migrations.
rake db:rollback      # Rolls the schema back to the previous version (specify steps w/ STEP=n).
rake db:version       # Retrieves the current schema version number.
```
