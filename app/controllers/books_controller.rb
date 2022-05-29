class BooksController < ApplicationController
  before_action :correct_user, only: [:edit, :update]
   def new
    @book = Book.new
   end
  
def create
  @user = current_user
  @book = Book.new(book_params)
  @book.user_id = current_user.id
  if @book.save
    redirect_to book_path(@book.id), flash: {notice:'You have created book successfully.'}
  else
    @books = Book.all 
    render :index
  end
end

  def index
    @user = current_user
    @books = Book.all
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
  end
  
  def update
    @book = Book.find(params[:id])
    if@book.update(book_params)
      redirect_to book_path(@book.id), flash: {notice:"You have updated book successfully."}
    else
    render :edit
    end
  end
  
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end
  
  private

  def book_params
    params.require(:book).permit(:title, :image, :body)
  end
  
  def correct_user
    @book = Book.find(params[:id])
    if current_user.id != @book.user.id
      redirect_to books_path
    end
  end

end
