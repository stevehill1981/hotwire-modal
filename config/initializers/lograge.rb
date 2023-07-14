Rails.application.configure do
  config.lograge.enabled = true
  config.lograge.formatter = Lograge::Formatters::Json.new

  config.lograge.custom_payload do |controller|
    metadata = {
      timestamp: Time.now.iso8601,
      remote_ip: controller.request.remote_ip,
      request_id: controller.request.request_id
    }

    if controller.user_signed_in?
      metadata[:user_id] = controller.current_user.id
    end

    metadata
  end
end
