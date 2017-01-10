class AddWebsiteToInsurance < ActiveRecord::Migration
  def change
    add_column :insurance_companies, :webiste, :string, :default => ""
  end
end
