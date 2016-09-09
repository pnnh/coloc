require 'rails_helper'

RSpec.describe Item, :type => :model do
  before do
    @tag = Tag.new(title: "new tag", contents: "new tag contents")
  end
  subject { @tag }
  
  it { should respond_to(:title) }
  it { should respond_to(:contents) }
  
  it { should be_valid }
  
  describe "when title and contents is nil" do
    before do
      @tag.title = ""
      @tag.content = ""
    end
    it { should_not be_valid }
  end
end
