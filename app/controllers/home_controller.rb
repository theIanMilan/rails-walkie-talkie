class HomeController < ApplicationController
  include HomeHelper

  def index
    @gs_tracker = GoogleSheetsTracker.find_or_create_by(id: 1)
    @gs_actual_rows = read_google_sheets_row_count
  end

  def route
    gs_tracker = GoogleSheetsTracker.find_or_create_by(id: 1)
    gs_database_rows = gs_tracker.rows

    worksheet = create_google_sheets_session_and_get_worksheet
    gs_actual_rows = worksheet.num_rows

    @newly_tracked_data = []
    @unsuccessful_data = []
    @difference = gs_actual_rows - gs_database_rows

    if gs_database_rows >= gs_actual_rows
      # Database > Actual: rows might have been deleted in GS
      GoogleSheetsTracker.first.update!(rows: gs_actual_rows)
    else
      # Database < Actual: arse new data
      worksheet.rows[gs_database_rows...gs_actual_rows].each do |new_row|
        # sample new_row data: ["11/12/2019 8:07:34", "one", "two", "two@test.com", "90"]
        response = talkpush_api_create_new_candidate(new_row[1], new_row[2], new_row[3], new_row[4])

        # Increment tracker
        gs_tracker.increment(:rows, 1)
        gs_tracker.save!

        if response.include?('succes')
          @newly_tracked_data << [new_row, response]
        else
          @unsuccessful_data << [new_row, response]
        end
      end
    end

    render :route
  end
end
