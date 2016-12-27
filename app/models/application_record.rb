class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.cached_all
    Rails.cache.fetch("#{self.name}/cached_all", expires_in: 30.minutes) do
      self.all.to_a
    end
  end
end
