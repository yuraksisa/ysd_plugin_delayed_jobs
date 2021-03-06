require 'sinatra/base'
require 'sinatra/r18n'
require 'data_mapper'
require 'ysd_plugin_delayed_jobs'
require 'ysd_yito_core'
require 'ysd_md_yito'

class TestingSinatraApp < Sinatra::Base
  register Sinatra::R18n
  helpers  Sinatra::YitoJsonRequestExtractor
  set :raise_errors, true
  set :dump_errors, false
  set :show_exceptions, false
end

Delayed::Backend::DataMapper::Job.extend Yito::Model::Finder

DataMapper::Logger.new(STDOUT, :debug)
DataMapper.setup :default, "sqlite3::memory:"
DataMapper::Model.raise_on_save_failure = true
DataMapper.finalize 

DataMapper.auto_migrate!