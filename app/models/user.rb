class User < ActiveRecord::Base
  has_many :group_assignments, -> { order("created_at DESC") }
  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  VALID_PHONE_REGEX = /(1?[ -.]?\(?\d{3}\)?[ -.]?\d{3}[ -.]?\d{4}[ extension\.]*\d{0,5})/i
  validates :phone, length: { maximum: 50 }, allow_blank: true,
                    format: { with: VALID_PHONE_REGEX, message: "format is invalid"  },
                    :on => :update
  validates_uniqueness_of :phone
  before_validation :format_phone
  default_scope{order(last_name: :asc)} 

  def first_name=(s)
    write_attribute(:first_name, s.to_s.titleize) # The to_s is in case you get nil/non-string
  end
  
  def last_name=(s)
    write_attribute(:last_name, s.to_s.titleize) # The to_s is in case you get nil/non-string
  end
  #strip non-numerical characters from phone number
  def format_phone
    if @phone != nil
      @phone = self.phone.scan(/[0-9]/).join
      self.phone = @phone.length == 7 ? ActionController::Base.helpers.number_to_phone(@phone) : 
      @phone.length == 10 ? ActionController::Base.helpers.number_to_phone(@phone, area_code: true) :
      @phone

    end
  end
end
