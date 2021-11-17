module HomeHelper
  require 'google_drive'
  require 'uri'
  require 'net/http'
  require 'json'

  def talkpush_api_create_new_candidate(fname, lname, email, phone_num)
    url = URI("https://my.talkpush.com/api/talkpush_services/campaigns/#{ENV.fetch('TALKPUSH_CAMPAIGN_ID')}/campaign_invitations")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true # Allow parsing of HTTPS requests

    request = Net::HTTP::Post.new(url)
    request['Content-Type'] = 'application/json'
    request['Cache-Control'] = 'no-cache'

    request.body = {
      api_key: ENV.fetch('TALKPUSH_API_KEY'),
      campaign_invitation: {
        first_name: fname,
        last_name: lname,
        email: email,
        user_phone_number: phone_num
      }
    }.to_json

    response = http.request(request)
    JSON.parse(response.body)
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
