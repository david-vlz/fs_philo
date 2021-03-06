# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  password_digest :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  remember_token  :string(255)
#  admin           :boolean          default(FALSE)
#

require 'spec_helper'

describe User do

	before { 
		@user = User.new(
			name: "Example User", 
			email: "user@example.com",
			password: "swordfish234!%&/",
			password_confirmation: "swordfish234!%&/"
		) 
	}
	
	subject { @user }
	
	it { should respond_to(:email) }
	it { should respond_to(:name) }
	it { should respond_to(:created_at) }
	it { should respond_to(:updated_at) }
	it { should respond_to(:password_digest) }
	it { should respond_to(:password) }
	it { should respond_to(:password_confirmation) }
	it { should respond_to(:authenticate) }
	it { should respond_to(:remember_token) }
	it { should respond_to(:admin) }
	
	it { should be_valid }
	it { should_not be_admin }
	
	describe "with admin attribute set to true" do
		before do
			@user.save!
			@user.toggle!(:admin)
		end
		
		it { should be_admin }
	end
	
	describe "when name is not present" do
		before { @user.name =" " }
		it { should_not be_valid }
	end
	
	describe "when name is too long" do
		before { @user.name = "a" * 51 }
		it { should_not be_valid }
	end
	
	describe "when name is too short" do
		before { @user.name = "ab" }
		it { should_not be_valid }
	end
	
	describe "when email is not present" do
		before { @user.email =" " }
		it { should_not be_valid }
	end
	
	describe "when email format is invalid" do
		it "should be invalid" do
			addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
			addresses.each do |invalid_address|
				@user.email = invalid_address
				@user.should_not be_valid
			end
		end
	end
	
	describe "when email format is valid" do
		it "should be valid" do
			addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
			addresses.each do |valid_address|
				@user.email = valid_address
				@user.should be_valid
			end
		end
	end
	
	describe "when email is already taken" do
		before do
			user_with_same_email = @user.dup
			user_with_same_email.email = @user.email.upcase
			user_with_same_email.save
		end
		it { should_not be_valid }
	end
	
	describe "email address with mixed case" do
		let(:mixed_case_email) { "bBLubB@eXamPLe.com" }
		
		it "should be saved as all lower-case" do
			@user.email = mixed_case_email
			@user.save
			@user.reload.email.should == mixed_case_email.downcase
		end
	end
	
	describe "when password is not present" do
		before { @user.password = @user.password_confirmation = " "; }
		it { should_not be_valid }
	end
	
	describe "when pasword and confirmation do not match" do
		before { @user.password_confirmation = @user.password[0...-1] }
		it { should_not be_valid }
	end
	
	describe "when password confirmation is nil" do
		before { @user.password_confirmation = nil }
		it { should_not be_valid }
	end
	
	describe "return value of authenticate method" do
		before { @user.save }
		let (:found_user) { User.find_by_email(@user.email) }
		
		describe "with valid password" do 
			it { should == found_user.authenticate(@user.password) }
		end

		describe "with invalid password" do
			let (:user_with_invalid_password) { found_user.authenticate(@user.password[0...-1]) }
			it { should_not == user_with_invalid_password }
			specify { user_with_invalid_password.should be_false }
		end
	end
	
	describe "with a password that is too short" do
		before { @user.password = @user.password_confirmation = 'a'*6 }
		it { should be_invalid }
	end
	
	describe "remember token" do
		before { @user.save }
		its(:remember_token) { should_not be_blank }
	end
	
	describe "accessible attributes" do
		it "should not allow access to the admin attribute" do
			expect do
				User.new(name: 'Exammple User', email: 'example@example.com', password: 'blue234', password_confirmation: 'blue234',
						 admin: true)
			end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
		end
	end
	
end
