class User < ActiveRecord::Base # :nodoc:
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:facebook]

  #->Prelang (user_login/devise)
  has_many :portfolios, dependent: :destroy
  has_many :registrations, dependent: :destroy
  has_many :institution_registered_academies, -> { where("registrations.reg_type = 'Institution'") }, through: :registrations, source: :academy
  has_many :standard_registered_academies, -> { where("registrations.reg_type = 'Standard'") }, through: :registrations, source: :academy
  has_many :payment_credentials, dependent: :destroy
  has_many :payments, dependent: :destroy

  validates :email, :username, presence: true
  validates :username, uniqueness: true
  validates_inclusion_of :active, in: [true, false]
  after_create :update_user_balance
  attr_accessor :login
  devise authentication_keys: [:login]

  SEARCH_CATAGORIES = [['Search for a Company', 'Company'], ['Search for an Academy', 'Academy'], ['Search for an Article', 'Article']].freeze

  def self.find_for_facebook_oauth(auth, _signed_in_resource = nil)
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
                password: Devise.friendly_token[0, 20])
  end

  #->Prelang (user_login:devise/username_login_support)
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(['lower(username) = :value OR lower(email) = :value', { value: login.downcase }]).first
    else
      where(conditions).first
    end
  end

  def is_standard_user?
    result = false
    result = true if type == 'Standard'
    result
  end

  def is_institution_user?
    result = false
    result = true if type == 'Institution'
    result
  end

  def is_registered?(academy)
    register = Registration.where(academy_id: academy.id, user_id: id, status: 'approve')
    if register.present?
      return true
    else
      return false
    end
  end

  def is_pending?(academy)
    register = Registration.where(academy_id: academy.id, user_id: id, status: 'pending')
    if register.present?
      return true
    else
      return false
    end
  end

  def is_owner?(academy)
    acd_ids = []
    academies = self.academies
    acd_ids = academies.ids if academies.present?

    if acd_ids.include? academy.id
      return true
    else
      return false
    end
  end

  def active_portfolio
    portfolios.where(active: true).first
  end

  def update_user_balance
    update_attributes(total_balance: 100_000)
  end

  def full_name
    first_name.try(:humanize) + ' ' + last_name.try(:humanize)
  end

  def update_total_balance(purchase)
    self.total_balance -= purchase.total_price
    save
  end

  def fetch_quandl_data(active_portfolio)
    main_data = []
    if active_portfolio.present?
      purchases = active_portfolio.purchases
      if purchases.present?
        purchases.each do |p|
          live_price = p.company.current_price
          latest_amount = (p.quantity * live_price).round(2)
          data = {}
          data[:purchase_id] = p.id
          data[:company_id] = p.company.id
          data[:company_name] = p.company.name
          data[:live_price] = live_price
          data[:quantity] = p.quantity
          data[:inv_price] = p.price
          data[:overall_gain] = (latest_amount - p.total_price).round(2)
          data[:inv_date] = p.created_at.strftime('%d/%m/%Y')
          main_data << data
        end
      end
    end

    main_data
  end
end
