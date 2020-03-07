class RelationshipsController < ApplicationController

    before_action :screen_user, only: [:destroy]

    def create
        unless params[:followed_id] == current_user.id
            relationship = Relationship.new
            relationship.follower_id = current_user.id
            relationship.followed_id = params[:followed_id]
            relationship.save
        end
        redirect_to(users_path)
    end

    def destroy
        relationship = Relationship.find(params[:id])
        relationship.destroy
        redirect_to(users_path)
    end

    private
    def screen_user
        relationship = Relationship.find(params[:id])
        unless relationship.follower_id == current_user.id
          redirect_to user_path(current_user)
        end
    end

end
