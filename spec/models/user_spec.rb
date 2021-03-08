require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'must be created with a password and password confirmation' do
      user = User.new
      user.first_name = 'first'
      user.last_name = 'last'
      user.email = 'test@testing.com'
      
      user.save
      expect(user.errors.full_messages).to include("Password can't be blank")
      expect(user.errors.full_messages).to include("Password confirmation can't be blank")
    end

    it 'password and password confirmation must match' do
      user = User.new
      user.first_name = 'first'
      user.last_name = 'last'
      user.email = 'test@testing.com'
      user.password = '123456'
      user.password_confirmation = '654321'      
      user.save
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'creates user if password and password confirmation match' do
      user = User.new
      user.first_name = 'first'
      user.last_name = 'last'
      user.email = 'test@testing.com'
      user.password = '123456'
      user.password_confirmation = '123456'      
      
      expect{user.save!}.to change{User.count}.by(1)
    end

    it 'emails must be unique (not case sensitive)' do
      existing_user = User.create(
        first_name: 'felix',
        last_name: 'cat', 
        email: 'test@test.com',
        password: '123456',
        password_confirmation: '123456'
      )

      user = User.new
      user.first_name = 'first'
      user.last_name = 'last'
      user.email = 'TEST@TEST.COM'
      user.password = '123456'
      user.password_confirmation = '123456'      
      
      user.save
      expect(user.errors.full_messages).to include("Email has already been taken")
    end

    it 'must have email, first name and last name' do
      user = User.new
      user.password = '123456'
      user.password_confirmation = '123456'      
      
      user.save
      expect(user.errors.full_messages).to include("First name can't be blank")
      expect(user.errors.full_messages).to include("Last name can't be blank")
      expect(user.errors.full_messages).to include("Email can't be blank")

    end

    it 'passwords must have minimum 4 characters' do
      user = User.new
      user.first_name = 'first'
      user.last_name = 'last'
      user.email = 'test@testing.com'
      user.password = '12'
      user.password_confirmation = '12'     
      
      user.save
      expect(user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end


  end

  describe '.authenticate_with_credentials' do
    it 'returns user if successful' do
      user = User.create(
        first_name: 'first',
        last_name: 'last',
        email: 'test@testing.com',
        password: '123456',
        password_confirmation: '123456'     
      )

      expect(user.authenticate_with_credentials('test@testing.com', '123456')).to be_a User

    end

    it 'returns nil if not successful' do
      user = User.create(
        first_name: 'first',
        last_name: 'last',
        email: 'test@testing.com',
        password: '123456',
        password_confirmation: '123456'     
      )

      expect(user.authenticate_with_credentials('test@testing.com', '654321')).to be_nil
    end

    it 'is successful and returns user if there are spaces before/after their email' do
      user = User.create(
        first_name: 'first',
        last_name: 'last',
        email: 'test@testing.com',
        password: '123456',
        password_confirmation: '123456'     
      )

      expect(user.authenticate_with_credentials('  test@testing.com ', '123456')).to be_a User

    end

    it 'is successful and returns user if email is in different case' do
      user = User.create(
        first_name: 'first',
        last_name: 'last',
        email: 'test@testing.com',
        password: '123456',
        password_confirmation: '123456'     
      )

      expect(user.authenticate_with_credentials('test@tEstiNg.com', '123456')).to be_a User

    end

  end

end
