class Plan < ActiveRecord::Base # :nodoc:
  has_many :subscriptions, dependent: :destroy

  def self.plan_select_options
  	Plan.all.map{|p| [options(p.name, p.price), p.id]}
  end

  def self.options(name, price)
  	"#{name}(#{price})"
  end
end
