# frozen_string_literal: true

class ArchiveAdvertisementsWorker < ApplicationWorker
  def perform(*_args)
    Advertisement.published.where('published_at < :time_ago', time_ago: 3.days.ago).find_each(&:archive!)
  end
end
