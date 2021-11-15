require 'rails_helper'

RSpec.describe HomeController do
  describe 'GET index' do
    it 'initializes @gs_tracker' do
      get :index
      expect(assigns(:gs_tracker).id).to eq(1)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end
  end
end
