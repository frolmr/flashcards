module PageVisitActivity
  def track_page_visit
    current_user.create_activity key: "#{controller_name}.#{action_name}", activity_type: 'page_visit', owner: current_user if current_user
  end
end
