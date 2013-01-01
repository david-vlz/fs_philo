# == Schema Information
#
# Table name: sections
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  article_id :integer
#

require 'spec_helper'

describe Section do
  
  before { @section = Section.new(title: 'Section Title', body: 'Section Text' ) }
  
  subject { @section }
  
  it { should respond_to(:title) }
  it { should respond_to(:body) }
  it { should respond_to(:article) }
  
end
