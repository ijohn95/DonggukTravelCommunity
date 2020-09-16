class MyPageController < ApplicationController
    before_action :authenticate_user! 
    def index
        @posts = Post.all.order('created_at desc') 
        @posts_count = current_user.posts.length 
    end
end
