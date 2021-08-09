class NotesController < ApplicationController
    def new
        @note = Note.new
    end

    def create
        @note = current_user.notes.build(note_params)
        if @note.save
            redirect_to user_book_path(current_user.id, @note.book_id) 
        else
            render :new
        end
    end

    def index
        @note = current_user.notes.all
    end

    def show
        @note = Note.find(params[:id])
    end

    def edit
        @note = Note.find(params[:id])
    end

    def update
        @note = Note.find(params[:id])
        if @note.update("title" => params["note"]["title"])
            redirect_to user_book_path(current_user.id, @note.book_id) 
        else 
            render "edit"
        end
    end

    def destroy
        @note = Note.find(params[:id])

        @note.destroy
        redirect_to user_book_path(current_user.id, @note.book_id) 
    end

    private

    def note_params
        params.require(:note).permit(:name, :title, :book_id, :user_id)
    end

end
