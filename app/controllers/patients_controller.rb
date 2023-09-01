class PatientsController < ApplicationController
  def index
    @patients = Patient.all
  end

  def show
  end

  def new
    @patient = Patient.new
  end

  def create
  end

  def update
  end

  def edit
  end

  def destroy
  end

  def search
    if params[:search].present?
      @patients = Patient.joins(:user).where('users.first_name LIKE ?', "%#{params[:search]}%")
    else
      @patients = Patient.all
    end
    render 'index'
  end
end
