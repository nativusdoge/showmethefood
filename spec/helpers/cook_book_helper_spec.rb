require File.dirname(__FILE__) + '/../spec_helper'

describe CookBookHelper do
  describe "shortening the description" do
    subject { shorten_description(@description) }
    
    before do
      @description = '12345678901234567890123456789012345678901234567890'
    end
    
    it "should shorten the description to 40 characters" do
      subject.size.should == 40
    end
    
    it "should change the last 3 characters to '...'" do
      subject.should == '1234567890123456789012345678901234567...'
    end
    
    it "should leave the string untouched if shorter than 44 characters" do
      @description = '1234567890'
      subject.should == '1234567890'
    end
  end
end