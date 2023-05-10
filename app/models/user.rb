class User < ActiveRecord::Base

  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_confirmation, presence: true
  validates :password, length:{ minimum:5 }

  before_create :format_email

  def self.authenticate_with_credentials(email, password)
    @formated_email = email.strip.downcase
    @user = User.find_by_email(@formated_email)

    if @user.authenticate(password)
      @user
    else
      nil
    end
  end

  private

  def format_email
    self.email = email.strip.downcase
  end

end