class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  protected
  def load_image
    path = ActionController::Base.helpers
                                 .image_path(Settings.no_image)
    image.nil? ? path : image
  end
end
