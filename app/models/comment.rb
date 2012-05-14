class Comment < ActiveRecord::Base
  after_create :set_ticket_state
  
  belongs_to :ticket
  belongs_to :user
  belongs_to :state
  
  delegate :project, :to => :ticket
  
  validates :text, :presence => true
  
  private
  
#    def set_previous_state
#      self.previous_state = ticket.state
#    end

    def set_ticket_state
      self.ticket.state = self.state
      self.ticket.save!
    end
    
#    def creator_watches_ticket
#      ticket.watchers << user
#    end
end