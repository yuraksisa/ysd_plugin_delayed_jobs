require 'ysd-plugins' unless defined?Plugins::Plugin

Plugins::SinatraAppPlugin.register :delayed_jobs do

   name=        'delayed jobs'
   author=      'yurak sisa'
   description= 'Delayed Jobs integration'
   version=     '0.1'
   sinatra_extension Sinatra::YSD::DelayedJob
   sinatra_extension Sinatra::YSD::DelayedJobRESTApi
   hooker Huasi::DelayedJobsExtension
end