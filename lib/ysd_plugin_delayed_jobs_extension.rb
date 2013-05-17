require 'ysd-plugins_viewlistener' unless defined?Plugins::ViewListener
require 'ysd_md_configuration' unless defined?SystemConfiguration::Variable

#
# Site Extension
#
module Huasi

  class DelayedJobsExtension < Plugins::ViewListener


    # --------- Menus --------------------
    
    #
    # It defines the admin menu menu items
    #
    # @return [Array]
    #  Menu definition
    #
    def menu(context={})
      
      app = context[:app]

      menu_items = [{:path => '/system/jobs',              
                     :options => {:title => app.t.system_admin_menu.delayed_jobs,
                                  :link_route => "/admin/worker-jobs",
                                  :description => 'Query delayed jobs',
                                  :module => :system,
                                  :weight => -1}
                    }
                    ]                      
    
    end    

    # ========= Routes ===================
    
    # routes
    #
    # Define the module routes, that is the url that allow to access the funcionality defined in the module
    #
    #
    def routes(context={})
    
      routes = [{:path => '/admin/worker-jobs',
                 :regular_expression => /^\/admin\/worker-jobs/, 
                 :title => 'Delayed jobs', 
                 :description => 'Query delayed jobs',
                 :fit => 1,
                 :module => :system }]
      
    end

  end #SystemExtension
end #Huasi