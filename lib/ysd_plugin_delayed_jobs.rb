require 'sinatra/ysd/ysd_sinatra_delayed_job'
require 'sinatra/ysd/ysd_sinatra_delayed_job_rest_api'

require 'ysd_plugin_delayed_jobs_extension'
require 'ysd_plugin_delayed_jobs_init'

require 'delayed_job_data_mapper'
Delayed::Backend::DataMapper::Job.extend Yito::Model::Finder
