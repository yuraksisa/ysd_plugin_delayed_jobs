require 'delayed_job_data_mapper'

module Sinatra
  module YSD
    #
    # REST API to manage Delayed jobs
    #
    module DelayedJobRESTApi

      def self.registered(app)
   
        ['/worker-jobs','/worker-jobs/page/:page'].each do |path|
          app.post path, :allowed_usergroups => ['staff'] do
            
            query_options = {}
            
            if request.media_type == "application/x-www-form-urlencoded"
              if params[:search]
                query_options[:conditions] = {:id => params[:search]} 
              else
                request.body.rewind
                search_text=request.body.read
                query_options[:conditions] = {:id =>search_text} 
              end
            end

            page_size = SystemConfiguration::Variable.
              get_value('delayed_jobs.page_size', 20).to_i 
  
            page = [params[:page].to_i, 1].max  

            data, total = Delayed::Backend::DataMapper::Job.all_and_count(
              query_options.merge({:offset => (page - 1)  * page_size, :limit => page_size}) )
            
            content_type :json
            {:data => data, :summary => {:total => total}}.to_json

          end
        end   
        
      end

    end #TemplateManagementRESTApi
  end #YSD
end #Sinatra