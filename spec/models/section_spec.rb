require 'spec_helper'

describe Section do
  
  before { @section = Section.new(title: 'Section Title', body: 'Section Text' ) }
  
  subject { @section }
  
  it { should respond_to(:title) }
  it { should respond_to(:body) }
  it { should respond_to(:article) }
  
end
