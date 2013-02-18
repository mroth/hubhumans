require 'spec_helper'

include Hubhumans

describe Humanifier do
  it "should be instantiated without any args" do
    lambda { Humanifier.new() }.should_not raise_error
    lambda { Humanifier.new( "moo ") }.should raise_error(ArgumentError)
  end

  describe '#render_user' do
    let(:humanifier) { Humanifier.new }
    before(:each) do
      @user = double("user")
      @user.stub(:name) {'Matthew Rothenberg'}
      @user.stub(:login) {'mroth'}
      @user.stub(:blog) {'http://mroth.info'}
      @user.stub(:location) {'Brooklyn, NY'}
      humanifier.client.should_receive(:user).and_return(@user)
    end

    it "should render appropriate text for a user" do
      humanifier.render_user('mroth').should == "  Matthew Rothenberg (mroth)\n  Site: http://mroth.info\n  Location: Brooklyn, NY\n\n"
    end
    it "should properly handle a user without a full name set" do
      @user.stub(:name) { nil }
      humanifier.render_user('mroth').should match(/^  mroth$/)
    end
    it "should properly omit location if user doesnt have one" do
      @user.stub(:location) { nil }
      humanifier.render_user('mroth').should_not match(/^  Location:/)
    end
    it "should properly omit blog if user doesnt have one" do
      @user.stub(:blog) { nil }
      humanifier.render_user('mroth').should_not match(/^  Site:/)
    end
  end
end
