class IdeaBoxApp < Sinatra::Base
	configure :development do
		register Sinatra::Reloader
	end
	
	require './idea'
	set :method_override, true
	
	get '/' do
		erb :index, locals: {ideas: Idea.all}
	end

	not_found do
		erb :error
	end
	
	delete '/:index' do |index|
		Idea.delete(index.to_i)
		redirect '/'
	end

	post '/' do
		idea = Idea.new(params['idea_title'], params['idea_description'])
		idea.save
		redirect '/'
	end
end
