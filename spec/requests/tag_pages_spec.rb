require 'rails_helper'

RSpec.describe "TagPages", :type => :request do
  subject { page }

  describe "create tag" do
    before { visit new_tag_path }
    let(:submit) { "Create" }

    describe "with invalid information" do
      it "should not create a tag" do
        expect { click_button submit }.not_to change(Tag, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Title", with: "First Tag"
        fill_in "Content", with: "First Tag Content"
      end
      it "should create a tag" do
        expect { click_button submit }.to change(Tag, :count).by(1)
      end
    end
  end
end
