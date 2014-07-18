class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable #, :confirmable

  has_many :wikis, dependent: :destroy
  has_many :collaborations
  has_many :shared_wikis, through: :collaborations, source: :wiki

  has_one :plan, dependent: :destroy

  validates_presence_of :plan_id
  
  attr_accessor :stripe_card_token
  
  def save_with_payment
    if valid?
      customer = Stripe::Customer.create(description: email, 
        plan: plan_id, card: stripe_card_token)
      self.stripe_customer_token = customer.id
      save!
    end
    
    rescue Stripe::InvalidRequestError => e  
    logger.error "Stripe error while creating customer: #{e.message}"  
    errors.add :base, "There was a problem with your credit card."
    false
  end
end
