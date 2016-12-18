class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  acts_as_messageable

  def mailboxer_email(object)
    email
  end

  has_attached_file :avatar, styles: { medium: "300x300#", thumb: "100x100#" }, 
	:default_url => "https://s3.amazonaws.com/fitchike-dev/profiles/avatars/missing_:style.jpg"
	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  has_many :bookings
  has_many :reviews, dependent: :destroy

  has_one :vendor
  belongs_to :gender
 
end

