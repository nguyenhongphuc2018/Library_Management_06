class Admin::BaseController < ApplicationController
  # authorize_resource
  # before_action :authenticate_user!
  layout "admin/application"
end
