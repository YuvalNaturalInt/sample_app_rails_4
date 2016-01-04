class MicropostsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      # How to send an Event - Create the Events::Demo::MicropostEvent event with the Events::Demo::MicropostData data, with the 'CREATED' key
      event_data = { data: Events::Demo::MicropostData.new(@micropost.attributes) }
      event = Events::Demo::MicropostEvent.new(event_data, 'CREATED')
      ::Hyrax::Publish::PublishEvent.instance.publish(event)
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    event_data = { data: Events::Demo::MicropostData.new(@micropost.attributes) }
    event = Events::Demo::MicropostEvent.new(event_data, 'DESTROYED')
    ::Hyrax::Publish::PublishEvent.instance.publish(event)
    redirect_to root_url
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end
