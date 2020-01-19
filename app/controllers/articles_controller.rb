class ArticlesController < ApplicationController
	before_action :set_article, only: [:destroy,:update,:show,:edit]
	before_action :require_user,except: [:show,:index]
	before_action :require_same_user, only: [:edit,:update,:destroy]

	def index
		@articles = Article.paginate(page: params[:page], per_page: 2)
	end

	def new
		@article = Article.new
	end

	def destroy
		@article.destroy
		flash[:danger] = "Article is deleted"
		redirect_to articles_path
	end

	def create
		@article =Article.new(article_params)
		@article.user = current_user
		if @article.save
			flash[:success] = "Article was created successfully"
			redirect_to article_path(@article) #redirect to the show
		else
			render 'new' #else new form empty wala is displayed
		end
	end

	def update
		if @article.update(article_params)
			flash[:success] = "Article is updated"
			redirect_to article_path(@article)
		else
			render 'edit'
		end
	end

	def show
	end

	def edit
	end

	private
	def article_params
		params.require(:article).permit(:title, :description)
	end

	def set_article
		@article = Article.find(params[:id])
	end

	def require_same_user
		if current_user != @article.user
			flash[:danger] = "You can only edit and delete your own articles."
			redirect_to root_path
		end
	end
end
