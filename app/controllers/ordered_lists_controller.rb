class OrderedListsController < ApplicationController
  def update
    @ordered_list = OrderedList.find(params[:id])
    authorize @ordered_list
    @error_content = ''
    @position = params[:position]
    if params[:github_nickname]
      @github_nickname = params[:github_nickname]
      user = User.find_by_slug(@github_nickname)
      if user
        if params[:add]
          @ordered_list.slugs << @github_nickname
          @ordered_list.save
        elsif params[:remove]
          @ordered_list.slugs.delete(@github_nickname)
          @ordered_list.save
        end
      else
        @error_content ='"' + @github_nickname + '" is not a valid github nickname.'
      end
    elsif params[:member_slugs]
      @ordered_list.update(slugs: params[:member_slugs])
    end
    @members = User.where(github_nickname: @ordered_list.slugs).sort_by {|t| @ordered_list.slugs.index(t.github_nickname) }
  end
end
