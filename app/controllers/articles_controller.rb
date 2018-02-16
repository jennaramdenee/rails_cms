class ArticlesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @articles = Article.all
  end

  def create
    body = Article.replace_images(params[:body])

    @article = Article.new(title: params[:title], summary: params[:summary], body: body)
  end

  def new
  end

  def show
    @article = Article.find_by(id: params[:id])
  end

  def update
  end

  def destroy
  end

  private

  def article_params
    params.require(:article).permit(:title)
  end
end
