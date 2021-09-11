# frozen_string_literal: true

# Users
User.create!(email: 'admin@admin.com', password: 'adminadmin', first_name: 'Admin',
             last_name: 'Adminovich', role: 'admin')
user_one = User.create!(email: 'user@user.com', password: 'useruser', first_name: 'User', last_name: 'Userovich',
                        role: 'user')
User.create!(email: 'user2@user2.com', password: 'user2user2', first_name: 'User2', last_name: 'Userovich2',
             role: 'user')

# Categories
cars_category = Category.create!(name: 'cars')
flowers_category = Category.create!(name: 'flowers')

# Advertisements
# published today
advertisemenet_published_today = Advertisement.create!(
  title: 'Published today',
  description: 'Published today',
  status: 'published',
  user: user_one,
  published_at: DateTime.current,
  category: cars_category
)

# published 5 days ago
Advertisement.create!(
  title: 'Published 5 days ago',
  description: 'Published 5 days ago',
  status: 'published',
  user: user_one,
  published_at: 5.days.ago,
  category: cars_category
)

# archived
Advertisement.create!(
  title: 'Archived',
  description: 'Archived',
  status: 'archived',
  user: user_one,
  category: cars_category
)

# draft
advertisement_draft = Advertisement.create!(
  title: 'Draft',
  description: 'Draft',
  status: 'draft',
  user: user_one,
  category: flowers_category
)

# pending preview
pending_preview = Advertisement.create!(
  title: 'Pending preview',
  description: 'Pending preview',
  status: 'pending_review',
  user: user_one,
  category: flowers_category
)
Advertisement.create!(
  title: 'Pending preview2',
  description: 'Pending preview2',
  status: 'pending_review',
  user: user_one,
  category: flowers_category
)

# approved
Advertisement.create!(
  title: 'Approved',
  description: 'Approved',
  status: 'approved',
  user: user_one,
  category: flowers_category
)

# rejected
Advertisement.create!(
  title: 'Rejected',
  description: 'Rejected',
  status: 'rejected',
  user: user_one,
  category: flowers_category
)

# Pictures
[advertisemenet_published_today, advertisement_draft, pending_preview].each do |advertisement|
  advertisement.files.attach(
    io: File.open(Rails.root.join('spec/support/files/picture.jpg')),
    filename: 'picture.jpg'
  )
end
