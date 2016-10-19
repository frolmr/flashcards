desc "Send pending cards notification email"
task :send_pending_card_notification => :environment do
  User.notify_pending_cards
end