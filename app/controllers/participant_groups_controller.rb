class ParticipantGroupsController < ApplicationController

  load_and_authorize_resource

  # PATCH/PUT /participant_group/1/group
  def update
    if @participant_group.update_attributes(group_param)
      redirect_to :back, notice: I18n.t('participant_groups.update.successful') rescue ActionController::RedirectBackError redirect_to root_path
    else
      redirect_to :back, alert: I18n.t('participant_groups.update.failed') rescue ActionController::RedirectBackError redirect_to root_path
    end
  end

  private

    def group_param
      params.require(:participant_group).permit(:group)
    end
end