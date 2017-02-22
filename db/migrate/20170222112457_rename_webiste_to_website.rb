class RenameWebisteToWebsite < ActiveRecord::Migration
  def change
    rename_column :insurance_companies, :webiste, :website
  end
end
