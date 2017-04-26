require 'delayed_job_data_mapper'

module Sinatra
  module YSD
    #
    # REST API to manage Delayed jobs
    #
    module DelayedJobRESTApi

      def self.registered(app)
   
        ['/api/worker-jobs','/api/worker-jobs/page/:page'].each do |path|
          app.post path, :allowed_usergroups => ['staff'] do
            
            query_options = {}
            
            if request.media_type == "application/json"
              request.body.rewind
              search_request = JSON.parse(URI.unescape(request.body.read))
              if search_request.has_key?('search') && !search_request['search'].empty?
                query_options[:conditions] = {:id => search_request['search']}
              end               
            end

            page_size = 20
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