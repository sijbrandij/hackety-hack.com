#you can view the forums at /forums
get "/forums" do

	#render that template!
	haml :"forums/index"
end

#you can view an individual forum here!
get "/forums/:forum" do
	
	#gotta find all the discussions in this forum
	@discussions = Discussion.all(:forum => params[:forum])

	#render the template!
	haml :"forums/show"
end

#you view a discussion here
get "/forums/:forum/:discussion" do
	@discussion = Discussion.first(:forum => params[:forum], :slug => params[:discussion])
	haml :"forums/discussion"
end

get "/forums/reply/to/:forum/:discussion" do
	@forum = params[:forum]
	@discussion = params[:discussion]

	haml :"forums/reply"
end

post "/forums/reply/to/:forum/:discussion" do
	@discussion = Discussion.first(:forum => params[:forum], :slug => params[:discussion])
	@discussion.replies << Reply.new(params[:reply])
	@discussion.save

	flash[:notice] = "Replied!"
	redirect "/forums/#{params[:forum]}/#{params[:discussion]}"
end