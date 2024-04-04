class AuthorsController < ApplicationController
  before_action :authenticate_user

  # GET /authors
  def index
    authors = Author.paginate(page: params[:page], per_page: 2)
    render json: authors
  end

  # GET /authors/1
  def show
    author = Author.find(params[:id])
    render json: author
  end

  # POST /authors
  def create
    author = Author.new(author_params)

    if author.save
      render json: author, status: :created, location: author
    else
      render json: author.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /authors/1
  def update
    author = Author.find(params[:id])
    if author.update(author_params)
      render json: author
    else
      render json: author.errors, status: :unprocessable_entity
    end
  end

  # DELETE /authors/1
  def destroy
    author = Author.find(params[:id])
    author.destroy
  end

  private

  # Only allow a trusted parameter "white list" through.
  def author_params
    params.require(:author).permit(:name, :bio)
  end

  def authenticate_user
    token = request.headers['Authorization']&.split(' ')&.last
    response = UserVerificationService.verify_token(token)
    render json: { error: 'Not Authorized' }, status: :unauthorized if response['error']
  end
end
