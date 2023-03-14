require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { User.new(:email => "m@gmail.com", :first_name => "Mary", :last_name => "Ary", :password => "12345", :password_confirmation => "12345") }

  describe 'Validations' do
    it 'is not valid without password' do
      user.password = nil
      expect(user).not_to be_valid
    end

    it 'is not valid without password_confirmation' do
      user.password_confirmation = nil
      expect(user).not_to be_valid
    end

    it 'confirm password and password_confirmation are not matching' do
      user.password_confirmation = "4231"
      user.save
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'confirm password and password_confirmation are not matching' do
      user.save
      expect(user.first_name).to eql("Mary")
    end

    it 'is not valid when email is not unique' do
      user.save
      user2 = User.new(:email => "M@gmail.com", :first_name => "Mary", :password => "12345", :password_confirmation => "12345")
      expect(user2).not_to be_valid
    end

    it 'confirm email should be required' do
      user.email = nil
      expect(user).not_to be_valid
    end

    it 'confirm name should be required' do
      user.first_name = nil
      user.save
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("First name can't be blank")
    end
  end

  describe '.authenticate_with_credentials' do
    it 'return nil when failed to authenticate' do
      user.save
      user = User.authenticate_with_credentials('m@gmail.com', '123485')
      expect(user).to eql(nil)
    end

    it 'return correct email when corectly authenticated' do
      user.save
      user = User.authenticate_with_credentials('m@gmail.com', '12345')
      expect(user).not_to eql(nil)
    end

    it 'can authenticate with case sensitive email address' do
      user.save
      user = User.authenticate_with_credentials('M@gmail.com', '12345')
      expect(user.email).to eql('m@gmail.com')
      expect(user).not_to eql(nil)
    end
  end

end
