class NotesController < ApplicationController
    def new
        @note = Note.new
    end

    def create
        @note = current_user.notes.build(note_params)
        if @note.save
            redirect_to books_path
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
        if @note.update_attribute("title",params["note"]["title"])
            redirect_to notes_path
        else 
            render "edit"
        end
    end

    def destroy
        @note = Note.find(params[:id])

        @note.destroy
        redirect_to notes_path
    end

    private

    def note_params
        params.require(:note).permit(:name, :title)
    end

end
