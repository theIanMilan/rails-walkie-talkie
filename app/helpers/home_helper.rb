module HomeHelper
  require 'google_drive'
  require 'uri'
  require 'net/http'
  require 'json'

  def talkpush_api_create_new_candidate(fname, lname, email, phone_num)
    url = URI("https://my.talkpush.com/api/talkpush_services/campaigns/#{ENV.fetch('TALKPUSH_CAMPAIGN_ID').to_i}/campaign_invitations")

    http = Net::HTTP.new(url.host, url.port)

    request = Net::HTTP::Post.new(url)
    request['Content-Type'] = 'application/json'
    request['Cache-Control'] = 'no-cache'

    json_hash = {
      api_key: ENV.fetch('TALKPUSH_API_KEY'),
      api_secret: ENV.fetch('TALKPUSH_API_SECRET'),
      campaign_invitation: {
        first_name: fname,
        last_name: lname,
        email: email,
        user_phone_number: phone_num
      }
    }
    request.body = JSON.generate(json_hash)

    response = http.request(request)
    puts response.read_body
    puts response.status
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
