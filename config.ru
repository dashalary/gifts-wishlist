require './config/environment'

# if ActiveRecord::Base.connection.migration_context.needs_migration?
#   raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
# end

if ActiveRecord::Migrator.needs_migration?
    raise 'Migrations are pending. Run `rake db:migrate SINATRA_ENV=test` to resolve the issue.'
  end

use Rack::MethodOverride # lets you use PATCH
use UsersController
use SessionsController
use CategoriesController
use ItemsController
run ApplicationController
