RailsAdmin.config do |config|
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.parent_controller = '::ApplicationController'
  config.current_user_method(&:current_user_or_guest)
  config.authorize_with :cancan
  config.excluded_models = %w(BookMaterial BookAuthor BookDimension OrderItem)
  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app
    state
  end
end
