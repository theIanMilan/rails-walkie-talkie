class CreateGoogleSheetsTrackers < ActiveRecord::Migration[6.1]
  def change
    create_table :google_sheets_trackers do |t|
      t.integer 'rows', default: 0
      t.timestamps
    end
  end
end
