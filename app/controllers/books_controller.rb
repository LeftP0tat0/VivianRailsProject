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

    def name_order
        @scope = params["scope"]["desired_attribute"]

        if @scope == "Long Names"
            @books = current_user.books.with_long_name
        elsif @scope == "Short Names"
            @books = current_user.books.with_short_name
        else
            @books = current_user.books.all
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
        params.require(:book).permit(:name)
    end

end
