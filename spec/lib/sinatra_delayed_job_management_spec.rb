require 'spec_helper'
require 'rack/test'

describe Sinatra::YSD::DelayedJob do 
  include Rack::Test::Methods
  
  def app
    TestingSinatraApp.class_eval do
      register Sinatra::YSD::DelayedJob
    end
    TestingSinatraApp
  end

  describe '/admin/worker-jobs' do
   
   before :each do
     app.any_instance.should_receive(:load_page).
       with(:delayed_jobs_management, 
       :locals => {:delayed_jobs_page_size => 20}).and_return('Hello World!')
   end

   subject do 
     get '/admin/worker-jobs'
     last_response       
   end

   its(:status) { should == 200 }

  end	

end