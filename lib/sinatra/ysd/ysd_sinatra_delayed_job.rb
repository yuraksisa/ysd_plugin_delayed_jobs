module Sinatra
  module YSD
  	#
  	# Sinatra extension to manage delayed jobs
  	#
  	module DelayedJob
      def self.registered(app)
        
        # Add the local folders to the views and translations     
        app.settings.views = Array(app.settings.views).push(File.expand_path(File.join(File.dirname(__FILE__), '..', '..', '..', 'views')))
        app.settings.translations = Array(app.settings.translations).push(File.expand_path(File.join(File.dirname(__FILE__), '..', '..', '..', 'i18n')))       

        app.get '/admin/worker-jobs', :allowed_usergroups => ['staff'] do

          load_page :delayed_jobs_management, 
            :locals => {:delayed_jobs_page_size => 20}

        end

      end
  	end
  end
end