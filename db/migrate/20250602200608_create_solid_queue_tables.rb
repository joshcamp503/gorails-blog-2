class CreateSolidQueueTables < ActiveRecord::Migration[7.1] # or your Rails version
  def change
    instance_eval(File.read(Rails.root.join("db/queue_schema.rb")))
  end
end
