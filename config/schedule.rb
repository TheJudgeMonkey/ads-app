# frozen_string_literal: true

every 1.day, at: '12:00 am' do
  rake 'publish_advertisements'
end

every 1.day, at: '11:50 pm' do
  rake 'archive_advertisements'
end
