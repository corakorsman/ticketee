class TicketsController < ApplicationController
  before_filter :find_project
  before_filter :find_ticket, :only => [:show,
                                        :edit,
                                        :update,
                                        :destroy]
  
  def new
    @ticket = @project.tickets.build
  end
  
  def create
    @ticket = @project.tickets.build(params[:ticket])
    if @ticket.save
      flash[:notice] = "Ticket has been created."
      redirect_to [@project, @ticket]
    else
      flash[:alert] = "Ticket has not been created."
      render :action => "new"
    end
  end

# Hey lieffie,
# Het is een kwestie van volgorde. Als je eenmaal hebt gezegd "private" 
# is elke methode die je daaronder schrijft binnen dezelfde class ook private,
# totdat je weer iets anders zegt zoals bijvoorbeeld 'public' of 'protected'
# de oplossing is dus om de echte acties die je beschikbaar wilt hebben (zoals
# 'show', 'edit' en 'update') *boven* de private neer te zetten, terwijl dingen als
# find_project en dergelijke nog steeds *onder* de private staan.

#  private
    def find_project
      @project = Project.find(params[:project_id])
    end
  
    def find_ticket
      @ticket = @project.tickets.find(params[:id])
    end
    
    def show
    end
    
    def edit
    end
    
    def update
      if @ticket.update_attributes(params[:ticket])
        flash[:notice] = "Ticket has been updated."
        redirect_to [@project, @ticket]
      else
        flash[:alert] = "Ticket has not been updated."
        render :action => "edit"
      end
    end
    
    def destroy
      @ticket.destroy
      flash[:notice] = "Ticket has been deleted."
      redirect_to @project
    end
end
