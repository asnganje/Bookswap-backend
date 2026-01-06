class Api::V1::BooksController < Api::V1::BaseController
  before_action :set_book, only: [ :show, :update, :destroy ]
  before_action :authorize_book!, only: [ :update, :destroy ]

  def index
    @books = Book.all.with_attached_image
    render json: @books.map { |b| serialize_book(b) }
  end

  def show
    render json: serialize_book(@book)
  end

  def create
    @book = current_user.books.build(book_params)
    if @book.save
      render json: serialize_book(@book), status: :created
    else
      render json: { errors: @book.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @book.update(book_params)
      render json: serialize_book(@book)
    else
      render json: { errors: @book.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy
    head :no_content
  end

  private
  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author, :genre, :image)
  end

  def serialize_book(book)
    {
      id: book.id,
      title: book.title,
      author: book.author,
      genre: book.genre,
      user_id: book.user_id,
      image_url: book.image_url
    }
  end

  def authorize_book!
    return if @book.user_id == current_user.id
    render json: { error: "Unauthorized" }, status: :unauthorized
  end
end
