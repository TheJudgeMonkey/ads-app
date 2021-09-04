# frozen_string_literal: true

class ApplicationWorker
  include Sidekiq::Worker

  def perform(*_args)
    raise NotImplementedError
  end
end
