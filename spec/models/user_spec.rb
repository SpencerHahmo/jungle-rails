require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it "validates that there is information in each area" do
      @user = User.new(first_name: "Spencer", last_name: "Hahmo", email: "schahmo@gmail.com", password: "testing", password_confirmation: "testing")
      expect(@user).to be_valid
      expect(@user.errors.full_messages).to be_empty
    end

    it "validates that the password and password_confirmation must match" do
      @user = User.new(first_name: "Spencer", last_name: "Hahmo", email: "schahmo@gmail.com", password: "testing", password_confirmation: "tested")
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to_not be_empty
      expect(@user.errors.full_messages[0]).to eq("Password confirmation doesn't match Password")
    end

    it "validates that the password and password_confirmation must exist" do
      @user = User.new(first_name: "Spencer", last_name: "Hahmo", email: "schahmo@gmail.com", password: nil, password_confirmation: nil)
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to_not be_empty
      expect(@user.errors.full_messages[0]).to eq("Password can't be blank")
      expect(@user.errors.full_messages[1]).to eq("Password confirmation can't be blank")
    end

    it "validates that the password must be a certain length" do
      @user = User.new(first_name: "Spencer", last_name: "Hahmo", email: "schahmo@gmail.com", password: "test", password_confirmation: "test")
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to_not be_empty
      expect(@user.errors.full_messages[0]).to eq("Password is too short (minimum is 5 characters)")
    end

    it "validates that there must be a first name for the user" do
      @user = User.new(first_name: nil, last_name: "Hahmo", email: "schahmo@gmail.com", password: "testing", password_confirmation: "testing")
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to_not be_empty
      expect(@user.errors.full_messages[0]).to eq("First name can't be blank")
    end

    it "validates that there must be a last name for the user" do
      @user = User.new(first_name: "Spencer", last_name: nil, email: "schahmo@gmail.com", password: "testing", password_confirmation: "testing")
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to_not be_empty
      expect(@user.errors.full_messages[0]).to eq("Last name can't be blank")
    end

    it "validates that there must be a email for the user" do
      @user = User.new(first_name: "Spencer", last_name: "Hahmo", email: nil, password: "testing", password_confirmation: "testing")
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to_not be_empty
      expect(@user.errors.full_messages[0]).to eq("Email can't be blank")
    end

    it "validates that an email can't be used if it already is used" do
      @user1 = User.create(first_name: "Spencer", last_name: "Hahmo", email: "schahmo@gmail.com", password: "testing", password_confirmation: "testing")
      @user2 = User.create(first_name: "Shawn", last_name: "Hahmo", email: "schahmo@gmail.com", password: "trial", password_confirmation: "trial")
      expect(@user2).to_not be_valid
      expect(@user2.errors.full_messages[0]).to eq("Email has already been taken")
    end

    it "validates that an email can't be used if it already is used if the email is spelled differently" do
      @user1 = User.create(first_name: "Spencer", last_name: "Hahmo", email: "schahmo@gmail.com", password: "testing", password_confirmation: "testing")
      @user2 = User.create(first_name: "Shawn", last_name: "Hahmo", email: "SCHahmo@gmail.com", password: "trial", password_confirmation: "trial")
      expect(@user2).to_not be_valid
      expect(@user2.errors.full_messages[0]).to eq("Email has already been taken")
    end
  end

  describe '.authenticate_with_credentials' do
    it "should authenticate a user with valid credentials" do
      @user = User.create(first_name: "Spencer", last_name: "Hahmo", email: "schahmo@gmail.com", password: "testing", password_confirmation: "testing")
      @logged_in = User.authenticate_with_credentials("schahmo@gmail.com", "testing")
      expect(@logged_in).to_not eq(nil)
    end

    it "should authenticate a user if they have trailing spaces in their email" do
      @user = User.create(first_name: "Spencer", last_name: "Hahmo", email: "  schahmo@gmail.com  ", password: "testing", password_confirmation: "testing")
      @logged_in = User.authenticate_with_credentials("schahmo@gmail.com", "testing")
      expect(@logged_in).to_not eq(nil)
    end

    it "should authenticate a user if they type the wrong case for their email" do
      @user = User.create(first_name: "Spencer", last_name: "Hahmo", email: "SCHahmo@gMail.com", password: "testing", password_confirmation: "testing")
      @logged_in = User.authenticate_with_credentials("schahmo@gmail.com", "testing")
      expect(@logged_in).to_not eq(nil)
    end

    it "should authenticate a user if they have trailing spaces in their email and type the wrong case for it" do
      @user = User.create(first_name: "Spencer", last_name: "Hahmo", email: "  SCHAHMO@GMAIL.COM  ", password: "testing", password_confirmation: "testing")
      @logged_in = User.authenticate_with_credentials("schahmo@gmail.com", "testing")
      expect(@logged_in).to_not eq(nil)
    end
  end
end
