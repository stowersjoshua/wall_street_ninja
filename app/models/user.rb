class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:facebook]

  #->Prelang (user_login/devise)
  has_many :portfolios, dependent: :destroy

  validates :email, :username, presence: true
  validates :username, uniqueness: true
  validates_inclusion_of :active, :in => [true, false]
  after_create :update_user_balance
  attr_accessor :login
  devise authentication_keys: [:login]
  
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(provider: auth.provider, uid: auth.uid).first

    # The User was found in our database
    return user if user

    # Check if the User is already registered without Facebook
    user = User.where(email: auth.info.email).first

    return user if user

    # The User was not found and we need to create them
    User.create(name:     auth.extra.raw_info.name,
                provider: auth.provider,
                uid:      auth.uid,
                email:    auth.info.email,
                password: Devise.friendly_token[0,20])
  end
  
  #->Prelang (user_login:devise/username_login_support)
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", {value: login.downcase}]).first
    else
      where(conditions).first
    end
  end

  def is_standard_user?
    result = false
    if self.type == "Standard"
      result = true
    end
    return result
  end

  def is_institution_user?
    result = false
    if self.type == "Institution"
      result = true
    end
    return result
  end

  def active_portfolio
    self.portfolios.where(active: true).first
  end

  def update_user_balance
    self.update_attributes(total_balance: 100000)
  end

  def full_name
    self.first_name.try(:humanize) + " " + self.last_name.try(:humanize)
  end
end
