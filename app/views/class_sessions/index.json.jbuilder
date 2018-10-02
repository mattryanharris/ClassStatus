json.array!(@class_sessions) do |class_session|
  json.extract! class_session, :name, :start_time, :end_time, :days
  json.url class_session_url(class_session, format: :json)
end
