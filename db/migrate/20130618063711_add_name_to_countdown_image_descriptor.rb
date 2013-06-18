class AddNameToCountdownImageDescriptor < ActiveRecord::Migration
  def change
    add_column :countdown_image_descriptors, :name, :string
  end
end
