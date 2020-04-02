class Api::V1::WidgetsController < Api::V1::ApiController
  skip_before_action :authenticate_request, only: [:create, :show]

  # GET /widgets
  def index
    @widgets = @user.widgets
    if @widgets.present?
      render :json => { :message => "Success!", :widgets => @user, :user => @user }.to_json
    else
      render json: {
                    "message": "widgets not found For #{current_user.email}.",
                  }, status: :ok
    end
  end

  # GET /users/1
  def show
    @widget = Widget.find_by_id(params[:id])
    render :json => { :message => "Success!", :widgets => @widget }.to_json
  end

  # POST /widgets
  def create
    @widget = Widget.new(widget_params)
    if @widget.save
      render json: {widget: @widget}, status: :created
    else
      render json: @widget.errors, status: :unprocessable_entity
    end
  end

  private
    def widget_params
      params.require(:widget).permit(
        Widget.column_names.map(&:to_sym)
      )
    end

end
