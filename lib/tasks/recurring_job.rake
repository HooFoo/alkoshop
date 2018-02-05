namespace :recurring do
  task init: :environment do
    Interactors::OrdersCleanupTask.schedule!
  end
end