class Api::ConversionsController < Api::BaseController
  before_action :doorkeeper_authorize!
  before_action :current_user_authenticate

  def create
    @original = Measurement.new(Rational(params[:from_value]), params[:from_unit])
    @converted = @original.convert_to(params[:to_unit])
  end
end
