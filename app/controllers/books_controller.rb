class BooksController < ApplicationController
    before_action :redirect_if_not_logged_in

    def new
        @book = Book.new
    end

    def create
        @book = current_user.books.build(book_params)
        if @book.save
            redirect_to books_path
        else
            render :new
        end
    end

    def index
        @books = current_user.books.all
    end

    def show
        @book = Book.find(params[:id])
    end

    def edit
        @book = Book.find(params[:id])
    end

    def update
        @book = Book.find(params[:id])
        if @book.update_attribute("name",params["book"]["name"])
            redirect_to books_path
        else 
            render "edit"
        end
    end

    def destroy
        @book = Book.find(params[:id])

        @book.destroy
        redirect_to books_path
    end

    private

    def book_params
        params.require(:book).permit(:name)
    end

end
