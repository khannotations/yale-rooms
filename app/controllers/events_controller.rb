class EventsController < ApplicationController
  respond_to :json

  def index
    respond_with Event.where(organization_id: params[:organization_id])
  end
end
