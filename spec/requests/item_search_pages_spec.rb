require 'rails_helper'

RSpec.describe "ItemSearchPages", type: :request do
  subject { page }
  describe "item search page" do
    before { visit new_item_search }

    it { should have_content('Item Search') }
    it { should have_title('Item Search')}
  end
end
