class ControllerAction < ActiveRecord::Base
  belongs_to :action_name
  belongs_to :controller_name

  has_many :interactions, dependent: :destroy
  has_many :roles, through: :interactions

  scope :controllers, lambda {|name| where("controller_name_id = ?", name)}
  scope :actions, lambda {|name| where("action_name_id = ?", name)}

  def initialized_interactions() # this is the key method
    [].tap do |o|
      Role.all.each do |r|
        if p = interactions.find { |p| p.role_id == r.id }
          o << p.tap { |p| p.enable ||= true }
        else
          o << Interaction.new(:role_id => r.id)
        end
      end
    end
  end
end
