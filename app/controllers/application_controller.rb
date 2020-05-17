require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  end

  #Displays all the articles
  #Collect all articles & store them in an instance variable
  #Render the index.erb page
  get "/articles" do
    @articles = Article.all
    erb :index
  end

  #Render the new.erb page which is a blank form
  get "/articles/new" do
    erb :new
  end

  #Recieves a post request from new.erb form
  #Use the params hash & AR to create a new article
  #Store this article instance in an instance variable @article
  #Render the show.erb page for the new article
  post "/articles" do
    @article = Article.create(params)
    redirect to "/articles/#{@article.id}"
  end


  #Displays a specific article
  #Use the params hash & AR to find an article by it's ID
  #Store this article instance in an instance variable @article
  #Render the show.erb page
  get "/articles/:id" do
    @article = Article.find(params[:id])
    erb :show
  end

  #Render the edit.erb page
  #Which is a form that's pre-populated
  #...with the existing title and content of the article
  get "/articles/:id/edit" do
    @article = Article.find(params[:id])
    erb :edit
  end

  #Recieves a patch request from the edit.erb form
  #Use the params hash to identify the article to delete
  #Use AR  & the params hash to edit & save the article
  #Render the show.erb page for the updated article
  patch "/articles/:id" do
    @article = Article.find(params[:id])
    @article.title = params[:title]
    @article.content = params[:content]
    @article.save
    redirect to "/articles/#{@article.id}"
  end

  #Recieves a delete request from the delete button in the show.erb form
  #Use the params hash to identify the article to delete
  #Use AR to delete the article
  #Redirect to the index of all articles
  delete "/articles/:id" do
    Article.destroy(params[:id])
    redirect to "/articles"
  end


end
