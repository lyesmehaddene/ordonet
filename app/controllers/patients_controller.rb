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
end
