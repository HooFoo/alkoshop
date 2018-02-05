module Interactors
  class OrdersCleanupTask
    include Delayed::RecurringJob

    run_every 1.day
    run_at '00:00'
    timezone 'Moscow'
    queue 'slow-jobs'

    def perform(*args)
      p 'Cleanup start'
      Order.where(price: 0).where('created_at <= ?', Time.now - 24.hours).each do |o|
        o.destroy
      end
    end
  end
end
