class Backoffice::SessionsController < ::Devise::SessionsController
  layout "backoffice_not_logged"
  # the rest is inherited, so it should work
end