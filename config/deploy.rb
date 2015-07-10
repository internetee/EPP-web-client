require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rbenv'  # for rbenv support. (http://rbenv.org)
# require 'mina/rvm'    # for rvm support. (http://rvm.io)

# Basic settings:
#   domain       - The hostname to SSH to.
#   deploy_to    - Path to deploy into.
#   repository   - Git repo to clone from. (needed by mina/git)
#   branch       - Branch name to deploy. (needed by mina/git)

# alpha branch
set :domain, 'registry-st'
set :deploy_to, '$HOME/demo-webclient'
set :repository, 'https://github.com/domify/webclient.git' # dev repo
set :branch, 'master'
set :rails_env, 'alpha'

# staging
task :st do
  set :domain, 'webclient-st'
  set :deploy_to, '$HOME/webclient'
  set :repository, 'https://github.com/internetee/EPP-web-client.git'
  set :branch, 'staging'
  set :rails_env, 'staging'
end

# production
task :pr do
  set :domain, 'webclient'
  set :deploy_to, '$HOME/webclient'
  set :repository, 'https://github.com/internetee/EPP-web-client.git' # production repo
  set :branch, 'master'
  set :rails_env, 'production'
end

# Manually create these paths in shared/ (eg: shared/config/database.yml) in your server.
# They will be linked in the 'deploy:link_shared_paths' step.
set :shared_paths, [
  'config/initializers/current_commit_hash.rb',
  'config/initializers/epp_host.rb',
  'config/secrets.yml',
  'config/application.yml',
  'log',
  'public/system',
  'public/assets'
]

# Optional settings:
#   set :user, 'foobar'    # Username in the server to SSH to.
#   set :port, '30000'     # SSH port number.

# This task is the environment that is loaded for most commands, such as
# `mina deploy` or `mina rake`.
task :environment do
  # Be sure to commit your .ruby-version to your repository.
  invoke :'rbenv:load'
end

# Put any custom mkdir's in here for when `mina setup` is ran.
# For Rails apps, we'll make some of the shared paths that are shared between
# all releases.
task setup: :environment do
  queue! %(mkdir -p "#{deploy_to}/shared/log")
  queue! %(chmod g+rx,u+rwx "#{deploy_to}/shared/log")

  queue! %(mkdir -p "#{deploy_to}/shared/config")
  queue! %(chmod g+rx,u+rwx "#{deploy_to}/shared/config")

  queue! %(mkdir -p "#{deploy_to}/shared/config/initializers")
  queue! %(chmod g+rx,u+rwx "#{deploy_to}/shared/config/initializers")

  queue! %(mkdir -p "#{deploy_to}/shared/public")
  queue! %(chmod g+rx,u+rwx "#{deploy_to}/shared/public")

  queue! %(mkdir -p "#{deploy_to}/shared/public/system")
  queue! %(chmod g+rx,u+rwx "#{deploy_to}/shared/public/system")

  queue! %(mkdir -p "#{deploy_to}/shared/public/assets")
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    to :launch do
      queue! 'gem install bundler'
      invoke :'bundle:install'
      queue %(echo '\n  NB! Please edit 'shared/config/database.yml'\n')
    end
  end
end

desc 'Deploys the current version to the server.'
task deploy: :environment do
  deploy do
    invoke :'git:clone'
    invoke :load_commit_hash
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:assets_precompile'
    to :launch do
      queue "mkdir -p #{deploy_to}/current/tmp; touch #{deploy_to}/current/tmp/restart.txt"
    end
  end
end

desc 'Loads current commit hash'
task load_commit_hash: :environment do
  queue! %(
    echo "CURRENT_COMMIT_HASH = '$(git --git-dir #{deploy_to}/scm rev-parse --short HEAD)'" > \
    #{deploy_to}/shared/config/initializers/current_commit_hash.rb
  )
end

# For help in making your deploy script, see the Mina documentation:
#
#  - http://nadarei.co/mina
#  - http://nadarei.co/mina/tasks
#  - http://nadarei.co/mina/settings
#  - http://nadarei.co/mina/helpers

