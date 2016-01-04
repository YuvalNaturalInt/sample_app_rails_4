# Listen to the domain from 'Demo' domain
Hyrax::DemoService.subscribe('Demo') do
  # Example for a simple subscribe for the 'Demo' domain and the 'Events::Demo::MicropostEvent.CREATED' key
  on("#{Events::Demo::MicropostEvent.name}.CREATED") do |payload|
    puts payload
  end

  # Example for a simple subscribe for the 'Demo' domain and the 'Events::Demo::MicropostEvent.DESTROYED' key with manual ack or manual reject
  on("#{Events::Demo::MicropostEvent.name}.DESTROYED", true) do |payload, manual_ack_callback, manual_reject_callback|
    puts payload
    manual_ack_callback.call
  end

 end