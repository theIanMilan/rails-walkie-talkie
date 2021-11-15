# README
View live on [heroku](https://walkie-talkie-11152021.herokuapp.com/)

## Problem
We made a google form asking for candidates to fill in their details for a job application. The form is linked to a google sheet, so once the form is filled and submitted, answers will appear in the google sheet.

## Solution
<!-- Checking GoogleSheets frequently still being looked upon, mainly through cron jobs built in heroku as the whenever gem is not supported in the chosen production server -->
Make a rails app that would check the GoogleSheet by making a button that force the app to check the google sheet. For every new row detected since the last update, you can make an API call to the Talkpush candidate function, so that we create a candidate with the GoogleForm information in our system.

## Documentation on Implementations
Workflow:
* On index page, read GSheets and return no. of rows
* Compare value to previous checking of no. of rows (Stored in the database as GoogleSheetsTracker.rows)
* If not equal, allow button to be clicked and routed to a function that checks and parses new rows
* For every new row, parse data and call Talkpush API to create candidate info
* For every 200 response code, print to Views created candidate data

### Google Credentials

#### On Heroku (Production Environment) 
Resource: [1](https://elements.heroku.com/buildpacks/buyersight/heroku-google-application-credentials-buildpack) and [2](https://dev.to/sylviapap/setting-heroku-config-vars-with-google-cloud-json-file-on-rails-4dnf) <br>
To make the .json credentials file by Google API available to Heroku, a buildpack was used to generate the `google-credentials.json` from heroku's config vars so it can be made available to the application without explicitly committing sensitive credentials.

#### On GitHub Actions
<!-- todo: https://docs.github.com/en/actions/security-guides/encrypted-secrets -->
Currently, the .json is not part of the GitHub workflow and as such all RSpec tests requiring Google API credentials fail. Locally however, RSpec tests pass. TODO: Encrypt .json for use in Github workflow.