require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
    before(:each) do
      @user = User.new(
        name: 'Bob Smith',
        email: 'bob@yahoo.com',
        password: '12345',
        password_confirmation: '12345'
      )
    end

    it "creates a new user" do
      expect(@user).to be_valid
    end

    it "should not create a user without a name" do
      @user.name = nil
      @user.save
      expect(@user).to_not be_valid
    end

    it "should not create a user without an email" do
      @user.email = nil
      @user.save
      expect(@user).to_not be_valid
    end

    it "should not create a user without a password" do
      @user.password = nil
      @user.save
      expect(@user).to_not be_valid
    end

    it "should not create a user without a password confirmation" do
      @user.password_confirmation = nil
      @user.save
      expect(@user).to_not be_valid
    end

    it "should not create a user with password different from password confirmation" do
      @user.password_confirmation = '12346'
      @user.save
      expect(@user).to_not be_valid
    end

    it "should not create a user with email that is not unique and not case-sensitive" do
      @user.save
      @user1 = User.new(
        name: 'Bob Jones',
        email: 'BoB@yahoo.com',
        password: '12345',
        password_confirmation: '12345'
      )
      expect(@user1).to_not be_valid
    end

    it "should not allow new user with password length less than 4" do
      @user.password = '123'
      @user.password_confirmation = '123'
      @user.save
      expect(@user).to_not be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    before(:each) do
      @user = User.new(
        name: 'Bob Smith',
        email: 'bob@yahoo.com',
        password: '12345',
        password_confirmation: '12345'
      )
      @user.save
    end
    it "should authenticate a user with spaces before email address" do
      user = @user.authenticate_with_credentials("   bob@yahoo.com", "12345")
      expect(user).to be_valid
    end

    it "should authenticate a user with wrong case in email address" do
      user = @user.authenticate_with_credentials("BoB@yAhoo.com", "12345")
      expect(user).to be_valid
    end
  end
end
