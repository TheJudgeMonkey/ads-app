# frozen_string_literal: true

desc 'Archive all published advertsements which are more than 3 days old'
task archive_advertisements: :environment do
  ArchiveAdvertisementsWorker.perform_async
end

desc 'Publish all approveed advertsements'
task publish_advertisements: :environment do
  PublishAdvertisementsWorker.perform_async
end
