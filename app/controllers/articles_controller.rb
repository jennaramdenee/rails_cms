require 'json'

class ArticlesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @articles = Article.all
  end

  def create
    request_body = JSON.parse(request.body.read)
    params_hash = Article.create_params_hash(request_body)
    # Make some new hash with params
    @article = Article.new(title: params_hash[:title], summary: params_hash[:summary], body: params_hash[:body])
    if @article.save
      redirect_to @article
    else
      raise StandardError, 'Failed to create article'
    end
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

  # private
  #
  # def article_params
  #   params.require(:article).permit(:title)
  # end
end
