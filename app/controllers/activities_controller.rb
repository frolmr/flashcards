class ActivitiesController < ApplicationController
  def index
    @activity = PublicActivity::Activity.order("created_at desc")
    @user_activity = get_activities(@activity, 'user')
    @cards_activity = get_activities(@activity, 'card')
    @api_activity = get_activities(@activity, 'api')
    @navigation_activity = get_activities(@activity, 'page_visit')
  end

  private

  def get_activities(activities_list, activity_type)
    activities_list.select { |record| record.activity_type == activity_type.to_s }
  end
end
