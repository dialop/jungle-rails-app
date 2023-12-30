require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe 'Validations' do

    # Verifies that a new user with all the correct attributes is valid
    it 'is valid with valid attributes' do
      user = User.new(
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password',
        first_name: 'John',
        last_name: 'Doe'
      )
      expect(user).to be_valid
    end

    # Checks the scenario where the password and password_confirmation fields do not match
    it 'is not valid without matching password and password_confirmation' do
      user = User.new(
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'differentpassword',
        first_name: 'John',
        last_name: 'Doe'
      )
      user.valid?
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password.")
    end
    

    # Ensures that the user is invalid if any required fields are missing
    it 'is not valid without required fields' do
      user = User.new
      user.valid?
      expect(user.errors.full_messages).to include("Email can't be blank.", "Password can't be blank.", "First name can't be blank.", "Last name can't be blank.")
    end

    # Tests if the email uniqueness validator works correctly, disregarding case sensitivity
    it 'is not valid with a non-unique email' do
      User.create(
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password',
        first_name: 'John',
        last_name: 'Doe'
      )

      user = User.new(
        email: 'TEST@example.com',
        password: 'differentpassword',
        password_confirmation: 'differentpassword',
        first_name: 'Jane',
        last_name: 'Doe'
      )
      user.valid?
      expect(user.errors.full_messages).to include("Email has already been taken.")
    end

    # Validates that the password must meet a specified minimum length
    it "is not valid with a password less than the minimum length" do 
      user = User.new(
        email: 'test@example.com',
        password: 'short',
        password_confirmation: 'short',
        first_name: 'John',
        last_name: 'Doe'
      )
      user.valid?
      expect(user.errors.full_messages).to include("Password is too short. Minimum is 12 characters.")
    end
  end

  # Testing the authentication method of the User model
  describe '.authenticate_with_credentials' do

    # Confirms that a user can be authenticated with correct email and password
    it 'returns the user instance for valid credentials' do
      user = User.create(
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password',
        first_name: 'John',
        last_name: 'Doe'
      )

      authenticated_user = User.authenticate_with_credentials('test@example.com', 'password')
      expect(authenticated_user).to eq(user)
    end

    # Asserts that authentication fails with an incorrect email
    it 'returns nil for incorrect email' do
      User.create(
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password',
        first_name: 'John',
        last_name: 'Doe'
      )

      authenticated_user = User.authenticate_with_credentials('wrong@example.com', 'password')
      expect(authenticated_user).to be_nil
    end

    # Checks that authentication fails with the incorrect password
    it 'returns nil for incorrect password' do
      User.create(
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password',
        first_name: 'John',
        last_name: 'Doe'
      )

      authenticated_user = User.authenticate_with_credentials('test@example.com', 'wrongpassword')
      expect(authenticated_user).to be_nil
    end

    # Verifies that authentication still succeeds when the email has leading/trailing spaces
    it 'ignores leading/trailing spaces in email' do
      user = User.create(
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password',
        first_name: 'John',
        last_name: 'Doe'
      )

      authenticated_user = User.authenticate_with_credentials('  test@example.com  ', 'password')
      expect(authenticated_user).to eq(user)
    end

   # Tests that the email authentication is case-insensitive
it 'ignores case in email' do
  user = User.create(
    email: 'test@example.com',
    password: 'password',
    password_confirmation: 'password',
    first_name: 'John',
    last_name: 'Doe'
  )

  authenticated_user = User.authenticate_with_credentials('TEST@example.com', 'password')
  expect(authenticated_user).to eq(user)
end

end 

end 