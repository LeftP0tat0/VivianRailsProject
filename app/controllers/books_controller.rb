class BooksController < ApplicationController
    before_action :redirect_if_not_logged_in
    

    def new
        @book = Book.new(user_id: params[:user_id])
    end

    def create
        @book = current_user.books.build(book_params)
        if @book.save
            redirect_to user_books_path(current_user.id)
        else
            render :new
        end
    end

    def index

        @books = current_user.books.all

        if params["book"]
            @params = params["book"]["desired_attribute"]
        end

    end

    def show
        @book = Book.find(params[:id])
        @notes = current_user.notes.all
        @note = Note.new
    end

    def edit
        @book = Book.find(params[:id])
    end

    def update
        @book = Book.find(params[:id])
        @note = current_user.notes.all
        if @book.update("name" => params["book"]["name"], "content" => params["book"]["content"])
            redirect_to user_books_path(current_user.id)
        else 
            render "edit"
        end
    end


    def destroy
        @book = Book.find(params[:id])
        @book.notes.destroy_all
        @book.destroy
        redirect_to user_books_path(current_user.id)
    end

    

    def book_params
        params.require(:book).permit(:name, :name_order, :scope_option)
    end

end
