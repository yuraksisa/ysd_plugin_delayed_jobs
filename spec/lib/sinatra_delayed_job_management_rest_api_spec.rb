require 'spec_helper'
require 'rack/test'
require 'delayed_job_data_mapper'
require 'json'

describe Sinatra::YSD::DelayedJobRESTApi do
  include Rack::Test::Methods

  let(:delayed_job) do
  	 {:priority => 1,
      :attempts => 2}
  end
  
  def app
    TestingSinatraApp.class_eval do
      register Sinatra::YSD::DelayedJobRESTApi
    end
    TestingSinatraApp
  end

  describe "POST /worker-jobs" do
    
    before :each do
      SystemConfiguration::Variable.should_receive(:get_value).
          with('delayed_jobs.page_size', 20).
          and_return(10) 
    end

    context "no pagination and no query" do

      before :each do
        Delayed::Backend::DataMapper::Job.should_receive(:all_and_count).
          with(hash_including({:offset => 0, :limit => 10})).
          and_return([[Delayed::Backend::DataMapper::Job.new(delayed_job)], 1])
      end

      subject do
        post '/worker-jobs', {}
        last_response
      end

      its(:status) { should == 200 } 
      its(:header) { should have_key 'Content-Type' }
      it { subject.header['Content-Type'].should match(/application\/json/) }
      its(:body) { should == {:data => [Delayed::Backend::DataMapper::Job.new(delayed_job)], :summary => {:total => 1}}.to_json }
    
    end

    context "pagination" do

      before :each do
        Delayed::Backend::DataMapper::Job.should_receive(:all_and_count).
          with(hash_including({:offset => 10, :limit => 10})).
          and_return([[Delayed::Backend::DataMapper::Job.new(delayed_job)], 1])
      end

      subject do
        post '/worker-jobs/page/2', {}
        last_response
      end

      its(:status) { should == 200 } 
      its(:header) { should have_key 'Content-Type' }
      it { subject.header['Content-Type'].should match(/application\/json/) }
      its(:body) { should == {:data => [Delayed::Backend::DataMapper::Job.new(delayed_job)], :summary => {:total => 1}}.to_json }

    end

    context "pagination and query" do

      before :each do
        Delayed::Backend::DataMapper::Job.should_receive(:all_and_count).
          with(hash_including(:offset => 10, :limit => 10)).
          and_return([[Delayed::Backend::DataMapper::Job.new(delayed_job)], 1])
      end

      subject do 
        post '/worker-jobs/page/2', {:search => 'text'}
        last_response
      end
      
      its(:status) {should == 200}
      its(:header) {should have_key 'Content-Type'}
      it { subject.header['Content-Type'].should match(/application\/json/) }
      its(:body) { should == {:data => [Delayed::Backend::DataMapper::Job.new(delayed_job)], :summary => {:total => 1}}.to_json }

    end

  end


end