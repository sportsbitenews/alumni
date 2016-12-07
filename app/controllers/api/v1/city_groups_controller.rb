class Api::V1::CityGroupsController < Api::V1::BaseController
  def index
    @city_groups_ordered_list = OrderedList.find_by_name('city_groups')
    if @city_groups_ordered_list
      @groups = CityGroup.where(slug: @city_groups_ordered_list.slugs).sort_by do |group|
        @city_groups_ordered_list.slugs.index(group.slug)
      end
    else
      @groups = CityGroup.all
    end
    @meetup_client = MeetupClientCache.new
  end
end
