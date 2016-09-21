class OrderedListsController < ApplicationController
  def update
    @ordered_list = OrderedList.find(params[:id])
    authorize @ordered_list
    @error_content = ''
    @position = params[:position]
    if params[:github_nickname]
      user = User.where('github_nickname ILIKE ?', params[:github_nickname]).first
      @github_nickname = user.github_nickname
      if user
        if params[:add]
          @ordered_list.slugs << @github_nickname
          @ordered_list.save
        elsif params[:remove]
          @ordered_list.slugs.delete(@github_nickname)
          @ordered_list.save
        end
      else
        @error_content ='"' + @github_nickname + '" is not a valid member of alumni.lewagon.org.'
      end
    elsif params[:member_slugs]
      @ordered_list.update(slugs: params[:member_slugs])
    end
    @members = User.where(github_nickname: @ordered_list.slugs).sort_by {|t| @ordered_list.slugs.index(t.github_nickname) }
  end
end
