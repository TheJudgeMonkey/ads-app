# frozen_string_literal: true

class PublishAdvertisementsWorker < ApplicationWorker
  def perform(*_args)
    Advertisement.approved.find_each do |advertisement|
      advertisement.update!(status: 'published', published_at: DateTime.current)
    end
  end
end
