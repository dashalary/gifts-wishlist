require './config/environment'

if ActiveRecord::Base.connection.migration_context.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride # lets you use PATCH
use UsersController
use SessionsController
use CategoriesController
use ItemsController
run ApplicationController
