class ContactSharesController < ApplicationController
  def create
    @share = ContactShare.new(share_params)
    if @share.save
      render json: @share
    else
      render(
        json: @share.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def destroy
    @share = ContactShare.find(params[:id])
    ContactShare.delete(@share)
    render json: @share
  end

  private
    def share_params
      params.require(:contact_share).permit(:contact_id, :user_id)
    end
end
