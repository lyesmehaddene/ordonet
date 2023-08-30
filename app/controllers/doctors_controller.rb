class DoctorsController < ApplicationController
  def show
  end

  def create
    @doctor = Doctor.new(strong_params)
    @doctor.user = current_user
    if @doctor.save
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def new
    @doctor = Doctor.new
  end

  def update
  end

  def edit
  end

  def destroy
  end

  private
  def strong_params
    params.require(:doctor).permit(:specialty, :accreditation_number)
  end
end
