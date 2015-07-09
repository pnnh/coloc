# coding: utf-8
require 'rails_helper'

RSpec.describe "ItemPages", :type => :request do
  subject { page }

  describe "index" do
    let(:item) { FactoryGirl.create(:item) }
    before { visit item_path(item) }
    
    #it { should have_title('条目列表') }
    it { should have_content('new item content') }

    describe "搜索条目" do
      FactoryGirl.create(:item, title:"emacs", markup:"markdown", content:"emacs content")
      before {visit item_path('e')}
      #it{raise page.body}
      it {should have_content('newitem')}
      it {should have_content('emacs')}
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
