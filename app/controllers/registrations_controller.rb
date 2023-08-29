class RegistrationsController < Devise::RegistrationsController
  def create
    super do |resource|
      if params[:user_type] == 'doctor'
        Doctor.create(user: resource)
      end
    end
  end
end
