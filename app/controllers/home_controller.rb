class HomeController < ApplicationController
  include HomeHelper

  def index
    @gs_tracker = GoogleSheetsTracker.find_or_create_by(id: 1)
    @gs_actual_rows = read_google_sheets_row_count
  end

  def route; end
end
