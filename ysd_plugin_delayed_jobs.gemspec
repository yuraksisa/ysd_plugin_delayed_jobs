Gem::Specification.new do |s|
  s.name    = "ysd_plugin_delayed_jobs"
  s.version = "0.1.5"
  s.authors = ["Yurak Sisa Dream"]
  s.date    = "2013-05-17"
  s.email   = ["yurak.sisa.dream@gmail.com"]
  s.files   = Dir['lib/**/*.rb','views/**/*.erb','i18n/**/*.yml','static/**/*.*'] 
  s.description = "Delayed jobs integration"
  s.summary = "Delayed jobs integration"
  
  s.add_runtime_dependency "json"

  s.add_runtime_dependency "ysd_core_plugins"
  s.add_runtime_dependency "ysd_yito_core"
  
  s.add_runtime_dependency "ysd_md_configuration" 
  s.add_runtime_dependency "ysd_plugin_auth"
  s.add_runtime_dependency "delayed_job_data_mapper"  

  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
  s.add_development_dependency "rack"
  s.add_development_dependency "rack-test"
  s.add_development_dependency "sinatra"
  s.add_development_dependency "sinatra-r18n"
  s.add_development_dependency "dm-sqlite-adapter" # Model testing using sqlite  
  
end