class Signup < ActiveRecord::Base
  before_save :generate_auth_token

  validates_presence_of :player1_name, :player1_dob_month, :player1_dob_day, :player1_dob_year
  validates_presence_of :player1_email, :player1_phone, :player1_address
  validates_presence_of :location, :tshirt_size
  
  def TEAM_SEXES
    [ "Boys", "Girls" ]
  end

  def DOB_MONTHS
    (1..12).to_a
  end
  def DOB_DAYS
    (1..31).to_a
  end
  def DOB_YEARS
    (Time.now.year-20..Time.now.year).to_a
  end
  
  def TSHIRT_SIZES
    [ "YS (Youth Small)", 
      "YM (Youth Medium)", 
      "YL (Youth Large)", 
      "YXL (Youth X-Large)", 
      "AS (Adult Small)", 
      "AM (Adult Medium)" ]
  end
  def LOCATIONS
    [ "Heroes Park", "JBIL Park" ]
  end
  
private
  def generate_auth_token
    if (self.auth_token.blank?)
      self.auth_token = ::ActiveSupport::SecureRandom.base64(15).tr('+/=', '-_ ').strip.delete("\n")
    end
  end
end
