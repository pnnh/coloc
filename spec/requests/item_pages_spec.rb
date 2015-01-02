require 'rails_helper'

RSpec.describe "ItemPages", :type => :request do
  subject { page }

  describe "create item" do
    before { visit new_item_path }
    let(:submit) { "Create" }

    describe "with invalid information" do
      it "should not create a item" do
        expect { click_button submit }.not_to change(Item, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Title", with: "First Item"
        fill_in "Content", with: "First Item Content"
      end
      it "should create a item" do
        expect { click_button submit }.to change(Item, :count).by(1)
      end
    end
  end
end
