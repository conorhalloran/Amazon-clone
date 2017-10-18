class ContactController < ApplicationController
    def contact 
    end
    def new
        @name = params[:name]
        @email = params[:email]
        @content = params[:content]
    end
end
