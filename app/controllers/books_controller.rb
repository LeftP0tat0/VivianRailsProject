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

        if params["book"]
            @params = params["book"]["desired_attribute"]
        end

    end

    def show
        @book = Book.find(params[:id])
        @notes = current_user.notes.all
        @note = Note.new
        @user = current_user
    end

    def edit
        @book = Book.find(params[:id])
    end

    def update
        @book = Book.find(params[:id])
        @note = current_user.notes.all
        if @book.update("name" => params["book"]["name"], "content" => params["book"]["content"])
            redirect_to books_path
        else 
            render "edit"
        end
    end

    def destroy
        @book = Book.find(params[:id])
        @note = current_user.notes.all
        @note.each do |note|
            if note.book_id == @book.id
                note.destroy
            end
        end
        @book.destroy
        redirect_to books_path
    end


    private

    def book_params
        params.require(:book).permit(:name, :name_order, :scope_option)
    end

end
