class BooksController < ApplicationController
  def index
    @books = Book.all
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to book_path(@book.id), notice: 'book was successfully created.'
    else
      @books = Book.all
      render :index
    end
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice: 'book was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    if book.destroy
    redirect_to '/books', notice: 'book was successfully deleted.'
    else
      flash.now[:alert] = 'error! Please Retry. '
      @books = Book.all
      render :index
    end
  end

  private
#ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
