class TagsController < ApplicationController
    def new
        @tag = tag.new
    end

    def create
        @tag = current_user.tags.build(tag_params)
        if @tag.save
            redirect_to "/books" 
        else
            render :new
        end
    end

    def destroy
        @tag = tag.find(params[:id])

        @tag.destroy
        redirect_to "/books" 
    end

    private

    def tag_params
        params.require(:tag).permit(:name, :content, :book_id, :user_id)
    end
end
