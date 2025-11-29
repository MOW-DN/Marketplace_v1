class Store::SubscribersController < Store::BaseController
  before_action :set_subscriber, except: [ :index ]

  def index
    @subscribers = Subscriber.includes(:product).filter_by(params)
  end

  def show
  end

  def destroy
    @subscriber.destroy
    redirect_to store_subscribers_path, notice: "Subscriber has been removed.", status: :see_other
  end

  private
    def set_subscriber
      @subscriber = Subscriber.find(params[:id])
    end
end