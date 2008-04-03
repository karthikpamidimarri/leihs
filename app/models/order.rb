class Order < ActiveRecord::Base

  belongs_to :user
  has_many :order_lines
  has_many :histories, :as => :target, :dependent => :destroy, :order => 'created_at ASC'

  acts_as_commentable

  NEW = 'new'
  APPROVED = "approved"
  REJECTED = "rejected"
  
  def self.new_orders
    find(:all, :conditions => {:status => Order::NEW})
  end


  def add_line(quantity, model, user_id)
    o = OrderLine.new(:quantity => quantity,
                      :model_id => model.to_i)
    log_change(_("Added") + " #{quantity} #{model.name}", user_id)
    order_lines << o
  end
  
  def update_line(line_id, required_quantity, user_id)
    line = order_lines.find(line_id)
    original = line.quantity
    line.quantity = required_quantity < max_available ? required_quantity : max_available
    change = _("Changed quantity for %{model} from %{from} to %{to}") % { :model => line.model.name, :from => original.to_s, :to => line.quantity }

    if required_quantity > max_available
      @flash_notice = _("Maximum number of items available at that time is %{max}") % {:max => max_available}
      change += " " + _("(maximum available)")
    end
    log_change(change, user_id)
    line.save
    [line, change]
    
  end
  
  #TODO: If you want to copy this method somewhere else, think about creating a acts_as_....
  def log_change(text, user_id)
    histories << History.new(:text => text, :user_id => user_id, :type_const => History::CHANGE)
  end
  
  #TODO: If you want to copy this method somewhere else, think about creating a acts_as_....
  def log_history(text, user_id)
    histories << History.new(:text => text, :user_id => user_id, :type_const => History::ACTION)
  end
  
  #TODO: If you want to copy this method somewhere else, think about creating a acts_as_....
  def has_changes?
    history = histories.find(:first, :order => 'created_at DESC, id DESC')
    history.nil? ? false : history.type_const == History::CHANGE
  end
  
  private
  
  def max_available
    10 #TODO: When we have reservations and stuff
  end
  
end
