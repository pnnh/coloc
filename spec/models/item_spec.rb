require 'rails_helper'

RSpec.describe Item, :type => :model do
  before do
    @item = Item.new(title: "new item", contents: "new item contents")
  end
  subject { @item }
  
  it { should respond_to(:title) }
  it { should respond_to(:contents) }
  
  it { should be_valid }
  
  describe "when contents is nil" do
    before do
      @item.title = ""
      @item.content = ""
    end
    it { should_not be_valid }
  end
end
