class Event < ApplicationRecord

 validates_presence_of :name, :friendly_id
 before_validation :generate_friendly_id, :on => :create

 validates_uniqueness_of :friendly_id
 validates_format_of :friendly_id, :with => /\A[a-z0-9\-]+\z/

 STATUS = [:draft, :public, :private]
 validates_inclusion_of :status, in: STATUS

 def to_param
  #  "#{self.id}-#{self.name}"
  self.friendly_id
 end

 protected

 def generate_friendly_id
   self.friendly_id = SecureRandom.uuid
 end

end
