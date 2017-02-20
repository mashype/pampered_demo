class Blogcomment < ActiveRecord::Base
  belongs_to :user
  belongs_to :blogpost
end
