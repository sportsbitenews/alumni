class OrderedListsController < ApplicationController
  def update
    @github_nickname = params[:github_nickname]
    @user = User.find_by_slug(@github_nickname)
    @position = params[:position]
    @ordered_list = OrderedList.find(params[:id])
    authorize @ordered_list

    if @user
      if params[:add]
        @ordered_list.slugs << @github_nickname
        @ordered_list.save
      elsif params[:remove]
        @ordered_list.slugs.delete(@github_nickname)
        @ordered_list.save
      end
    end

    @members = User.where(github_nickname: @ordered_list.slugs).sort_by {|t| @ordered_list.slugs.index(t.github_nickname) }
  end
end
