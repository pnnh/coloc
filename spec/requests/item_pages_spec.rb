require 'rails_helper'

RSpec.describe "ItemPages", :type => :request do
  subject { page }

  describe "index" do
    let(:item) { FactoryGirl.create(:item) }
    before { visit items_path }
    it { should have_title('All items') }
    it { should have_content('All items') }
    
    describe "pagination" do
      before(:all) { 30.times { FactoryGirl.create(:item) } }
      after(:all) { Item.delete_all }
      it { should have_selector('div.pagination') }
      it "should list each item" do
        Item.paginate(page: 1).each do |item|
          expect(page).to have_selector('li', text: item.title)
        end
      end
    end
  end
  
  describe "show page" do
    let(:item) { FactoryGirl.create(:item) }
    before { visit item_path(item) }
    it { should have_title(item.title) }
    it { should have_content(item.title) }
    it { should have_content(item.content) }

    describe "delete links" do
      it { should_not have_link('delete') }
      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit item_path(item)
        end
        it { should have_link('delete', href: item_path(item)) }
        it "should be able to delete item" do
          expect do
            click_link('delete')
          end.to change(Item, :count).by(-1)
        end
      end
    end
  end

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

  describe "edit" do
    let(:item) { FactoryGirl.create(:item) }
    before { visit edit_item_path(item) }
    describe "page" do
      it { should have_content("Update Item") }
      it { should have_title("Edit item") }
    end
    describe "with invalid information" do
      before { click_button "Save changes" }
      it { should have_content('error') }
    end
    describe "with valid information" do
      let(:new_title) { "New title" }
      let(:new_content) { "New content" }
      before do
        fill_in "title", with: new_title
        fill_in "content", with: new_content
        click_button "Save changes"
      end
      it { should have_title(new_title) }
      it { should have_selector('div.alert.alert-success') }
      specify { expect(item.reload.title).to eq new_title }
      specify { expect(item.reload.contnet).to eq new_content }
    end
  end
end
