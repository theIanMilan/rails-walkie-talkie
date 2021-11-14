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
    worksheet.rows.count
  end

  def create_google_sheets_session_and_get_worksheet
    # Creates a session. This will prompt the credential via command line for the
    # first time and save it to config.json file for later usages.
    # See this document to learn how to create config.json:
    # https://github.com/gimite/google-drive-ruby/blob/master/doc/authorization.md
    session = GoogleDrive::Session.from_service_account_key('client_secret.json')
    session.spreadsheet_by_key(ENV.fetch('SPREADSHEET_ID')).worksheets[0]
  end
end
