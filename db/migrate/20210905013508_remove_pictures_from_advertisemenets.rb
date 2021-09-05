class RemovePicturesFromAdvertisemenets < ActiveRecord::Migration[6.1]
  def change
    remove_column :advertisements, :pictures
  end
end
