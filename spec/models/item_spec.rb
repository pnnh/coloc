require 'rails_helper'

RSpec.describe Item, :type => :model do
  before do
    @item = Item.new(title: "new item", content: "new item content")
  end
  subject { @item }
  
  it { should respond_to(:title) }
  it { should respond_to(:content) }
  
  it { should be_valid }
  
  describe "when content is nil" do
    before do
      @item.title = ""
      @item.content = ""
    end
    it { should_not be_valid }
  end
end
