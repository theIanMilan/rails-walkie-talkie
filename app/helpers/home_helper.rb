module HomeHelper
  require 'google_drive'

  def comment
    # @api_token = '1'
    # api_link = ""

    # uri = URI.parse(api_link)
    # http = Net::HTTP.new(uri.host, uri.port)
    # http.use_ssl = true
    # http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    # request = Net::HTTP::Get.new(uri.request_uri)
    # response = http.request(request)

    # parsed_results = JSON.parse(response.body)
    # parsed_results['data']
  end

  def read_google_sheets_row_count
    worksheet = create_google_sheets_session_and_get_worksheet
    worksheet.num_rows
  end

  def create_google_sheets_session_and_get_worksheet
    # Creates a Google Sheets session using service_account.json obtained from Google API
    client_secret = ENV.fetch('GOOGLE_APPLICATION_CREDENTIALS')
    session = GoogleDrive::Session.from_service_account_key(client_secret)
    session.spreadsheet_by_key(ENV.fetch('SPREADSHEET_ID')).worksheets[0]
  end
end
