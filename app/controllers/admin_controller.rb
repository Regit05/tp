class AdminController < ApplicationController

    #http_basic_authenticate_with name: "user", password: "password", except: []
     before_action :verif_connexion, except: [:connexion]

        def connexion
            @admins = Admin.all
        end

        def verif_connexion
            if !session[:user]
                redirect_to connexion_path
            end
        end





        def new
          @admin = Admin.new
        end

        def index
          @admins = Article.all
        end

        def show
          @admin = Article.find(params[:id])
          @comments = @admin.comments.all
        end

        def edit
          @article = Article.find(params[:id])
        end

        def update
          @article = Article.find(params[:id])

          if @article.update(article_params)
            redirect_to @article
          else
            render 'edit'
          end
        end

        def destroy
          @article = Article.find(params[:id])
          @article.destroy

          redirect_to articles_path
        end


         private
              def admins_params
                params.require(:admin).permit(:email,:password, :timestamps)
              end

end
