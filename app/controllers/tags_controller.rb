class TagsController < ApplicationController

    def index
        @tags = Tag.order(name: :desc)
    end

    def show
        @tag = Tag.find(params[:id])
    end
end
