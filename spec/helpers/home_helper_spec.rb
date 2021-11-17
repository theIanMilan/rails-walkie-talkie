require 'rails_helper'

describe HomeHelper do
  describe '#read_google_sheets_row_count' do
    it 'returns an integer' do
      expect(helper.read_google_sheets_row_count.class).to eq(Integer)
    end
  end

  describe '#create_google_sheets_session_and_get_worksheet' do
    it 'returns a GoogleDrive Worksheet class and has proper sheet ID' do
      worksheet = helper.create_google_sheets_session_and_get_worksheet
      expect(worksheet.class).to eq(GoogleDrive::Worksheet)
      expect(worksheet.gid).to eq(ENV.fetch('SHEET_ID'))
    end
  end
end
