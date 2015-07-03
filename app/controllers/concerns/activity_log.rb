module ActivityLog
  def create_activity user_id, type_id, status
    Activity.create! user_id: user_id, type_id: type_id, status: status
  end
end
