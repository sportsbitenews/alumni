class OrderedListsController < ApplicationController
  def update
    @city = City.find(params[:city_id])
    @github_nickname = params[:github_nickname]
    @user = User.find_by_slug(@github_nickname)
    @role = params[:role]
    ol = OrderedList.find_by_name("#{@city.slug}_#{@role}s")
    authorize ol
    if params[:add]
      ol.slugs << @github_nickname
      ol.save
    elsif params[:remove]
      ol.slugs.delete(@github_nickname)
      ol.save
    end
    @teachers = User.where(github_nickname: ol.slugs).sort_by {|t| ol.slugs.index(t.github_nickname) }
    @teacher_assistants = User.where(github_nickname: ol.slugs).sort_by {|t| ol.slugs.index(t.github_nickname) }
  end
end
