# name: discourse-opencollective-plugin
# about: This is intended to be a feature-rich plugin for opencollective-discourse integration
# version: 1.0.0
# authors: Sudaraka Jayathilaka
# url: https://github.com/sudaraka94/discourse-opencollective-plugin.git




require 'net/http'
require 'uri'
require 'json'

after_initialize do
	class ::Jobs::ExampleJob < Jobs::Scheduled
	every 2.seconds

	    def execute(args)
	      	# Acquiring data from the open collective
			url='https://opencollective.com/webpack/sponsors.json'
			uri=URI(url)
			data=Net::HTTP.get(uri)
			# save the acquired json into plugin store
			::PluginStore.set('discourse-opencollective-plugin','user_data', data)
			retrieve=::PluginStore.get('discourse-opencollective-plugin','user_data')
			parsed=JSON.parse(retrieve)
			# Iterates through users
			parsed.each do |user|
				puts user['name']
			end
    end

  end

 	require_dependency 'application_controller'
  
 	class ::OpencollectiveController < ::ApplicationController
	  	#This class will contain all the back end controller methods 
	    requires_plugin 'opencollective-plugin'
	    require_dependency 'admin_constraint'
	    #this will return the JSON of users in the plugin store 
	    def list
	    	user_list=::PluginStore.get('discourse-opencollective-plugin','user_data')
	    	parsed=JSON.parse(user_list)
	    	render json: parsed
	    end
	end

	add_admin_route 'discourse-opencollective-plugin.title', 'opencollective'

	Discourse::Application.routes.append do
	  get '/admin/plugins/opencollective' => 'admin/plugins#index'
	  get '/admin/plugins/opencollective/list' => 'opencollective#list'
	end

end

