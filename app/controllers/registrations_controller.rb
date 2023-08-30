class RegistrationsController < Devise::RegistrationsController
  def after_sign_up_path_for(resource)
    # Customize this to return the path you want to redirect to after sign-up.
    # For example, you can use named route helpers or hardcode the path.
    # Replace with the path you want
    new_doctor_path
  end
end
