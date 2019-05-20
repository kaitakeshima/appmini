class ArticlesController < ApplicationController

 before_action :move_to_index, except: :index



def index
  @article = Article.includes(:user).page(params[:page]).per(10).order("created_at DESC")
end

def new
end

def create
  Article.create(text: article_params[:text], user_id: current_user.id)
  
end  

def destroy
  article = Article.find(params[:id])
  article.destroy if article.user_id == current_user.id
    
end

def edit
  @article = Article.find(params[:id])
end  

def update
  article = Article.find(params[:id])
  if article.user_id == current_user.id
    article.update(article_params)
  end
end


private

def article_params
  params.permit(:text)
end

def move_to_index
  redirect_to action: :index unless user_signed_in?
end  

end
