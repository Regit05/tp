  class ArticlesController < ApplicationController

    http_basic_authenticate_with name: "user", password: "password", except: [:index, :show, :search]

    #before_action do |variable|
    #    puts 'Je suis le Before !!!'
    #end
    before_action :set_article, only: [:edit, :update, :show, :destroy]

    after_action do |variable|
        puts 'Je suis le After !!!'
    end

    around_action :around
    def around
        puts "Before !!!"
        yield
        puts "After !!!"
    end

    def new
      @article = Article.new
    end

    def index
      #session[:user] = {id: '123', username: 'Regit05'}
      @articles = Article.online(true).by_updated_at.all

    end

    def show
      #@article = Article.find(params[:id])
      #@session = session[:user]
      @comments = @article.comments.all
    end

    def edit
      #@article = Article.find(params[:id])
    end

    def update
      #@article = Article.find(params[:id])

      if @article.update(article_params)
        flash[:success] = "Post modifié avec succés"
        redirect_to admin_path(@article)
      else
        flash[:danger] = "Le post n'a pas pu être modifié"
        redirect_to edit_article_path(@article)
      end
    end

    def destroy
      #@article = Article.find(params[:id])
      @article.destroy

      redirect_to admins_path
    end

    def create
      #render plain: params[:article].inspect

      #@article = Article.new(params.require(:article).permit(:title,:text))
      @article = Article.new(article_params)
      #@article.save
      #redirect_to @article

      if @article.save
        redirect_to admin_path(@article)
      else
        render 'new'
      end
    end

    def search
        #render plain: params[:search].inspect
        @articles = Article.online(true).where(Article.arel_table[:title].matches("%#{params[:search]}%")).by_updated_at
        #.paginate(page: params[:page], per_page: 3)
    end


    private
      def article_params
        params.require(:article).permit(:title,:text,:image_url)
      end

      def set_article
        @article = Article.find(params[:id])
      end
  end
