class IdeaBoxApp < Sinatra::Base
	configure :development do
		register Sinatra::Reloader
	end
	
	require './idea'
	set :method_override, true
	
	get "/game" do
		erb :game
	end
	get '/' do
		erb :index, locals: {ideas: Idea.all}
	end
	get '/:id/edit' do |id|
		idea = Idea.find(id.to_i)
		erb :edit, locals: {id: id, idea: idea}
	end
	put '/:id' do |id|
		data = {
			:title => params['idea_title'],
			:description => params['idea_description']
		}
		Idea.update(id.to_i, data)
		redirect '/'
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
