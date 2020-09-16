class DislikesController < ApplicationController
    before_action :authenticate_user! 
    
    def dislike_toggle
        dislike = Dislike.find_by(user_id: current_user.id, post_id: params[:post_id])
        
        if dislike.nil?
            Dislike.create(user_id: current_user.id, 
                        post_id: params[:post_id]) 
        else
            dislike.destroy 
        end
        
        redirect_to root_path
        'redirect_to :back'
    end 

end
