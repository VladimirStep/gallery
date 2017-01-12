require 'rails_helper'

RSpec.describe AdminUser, type: :model do
  before { @admin_user = build(:admin_user) }

  subject { @admin_user }

  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:encrypted_password) }
  it { should respond_to(:reset_password_token) }
  it { should respond_to(:reset_password_sent_at) }
  it { should respond_to(:remember_created_at) }
  it { should respond_to(:sign_in_count) }
  it { should respond_to(:current_sign_in_at) }
  it { should respond_to(:last_sign_in_at) }
  it { should respond_to(:current_sign_in_ip) }
  it { should respond_to(:last_sign_in_ip) }
  it { should be_valid }

  describe 'when email is not present' do
    before { @admin_user.email = ' ' }

    it { should_not be_valid }
  end

  describe 'when password is not present' do
    before { @admin_user.password = ' ' }

    it { should_not be_valid }
  end

  describe 'when password confirmation does not match password' do
    before { @admin_user.password_confirmation = 'mismatch' }

    it { should_not be_valid }
  end

  describe 'when email format is invalid' do
    it 'should be invalid' do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @admin_user.email = invalid_address
        expect(@admin_user).not_to be_valid
      end
    end
  end

  describe 'when email format is valid' do
    it  do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @admin_user.email = valid_address
        expect(@admin_user).to be_valid
      end
    end
  end

  describe 'when email address is already taken' do
    before do
      user_with_same_email = @admin_user.dup
      user_with_same_email.email = @admin_user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe 'when password is too long' do
    before { @admin_user.password = 'a' * 129 }

    it { should_not be_valid }
  end

  describe 'when password is too short' do
    before { @admin_user.password = 'a' * 5 }

    it { should_not be_valid }
  end
end
