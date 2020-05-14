
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end


   get '/' do
     redirect to "/articles"
   end

   #Responds with a 200 status code
   #Displays all the articles
   #Renders index form
   get "/articles" do
    @articles = Article.all
    erb :index
   end

   #Render new article form
   get "/articles/new" do
     erb :new
   end

   #Create new article 
   #Redirect to the show page
   post "/articles" do
     @article = Article.create(title: params[:title], content: params[:content])
     redirect to "/articles/#{@article.id}"
   end          
 
   #Responds with a 200 status code
   #Find a specific article
   #Renders show form
   get "/articles/:id" do
    @article = Article.find_by_id(params[:id])
    erb :show
   end
   
   #Find a specific article
   #Render the edit form
   get "/articles/:id/edit" do
    @article = Article.find_by_id(params[:id])
    erb :edit
   end

   #Submit the form via a patch request
   #Find a specific article
   #Update each of its articles - even if they remain the same
   #Save the changes to the database
   #Redirect to the show page
   patch "/articles/:id" do
    @article = Article.find_by_id(params[:id])
    @article.title = params[:title]
    @article.content = params[:content]
    @article.save
    redirect to "/articles/#{@article.id}"
   end

   #Responds with a 200 status code
   #Find a specific article & delete it from the database
   #Redirect to the index page
   delete "/articles/:id" do
    @article = Article.find_by_id(params[:id])
    @article.destroy
    redirect to "/articles"
   end



  

  # # edit
  # get "/articles/:id/edit" do
  #   @article = Article.find(params[:id])
  #   erb :edit
  # end

  # # update
  # patch "/articles/:id" do
  #   @article = Article.find(params[:id])
  #   @article.update(params[:article])
  #   redirect to "/articles/#{ @article.id }"
  # end

end
