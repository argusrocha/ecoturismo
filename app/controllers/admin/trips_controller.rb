class Admin::TripsController < ApplicationController
  before_filter :authenticate_user!

  respond_to :html

  def index
    authorize! :read, Trip

    @trips = Trip.all.decorate

    respond_to do |format|
      format.html
      format.pdf do
        pdf = TripsPdf.new(@trips)
        send_data pdf.render, filename: pdf.filename, type: 'application/pdf'
      end
    end
  end

  def show
    authorize! :read, Trip
    @trip = Trip.find(params[:id])
  end

  def new
    authorize! :create, Trip
    @trip = Trip.new
  end

  def create
    authorize! :create, Trip

    @trip = Trip.new(trip_params)
    @trip.users.each do |user_trip|
      @trip.transactions << @trip.transactions.build(description: @trip.description, type: :debit, compensated: true, value: @trip.value, user: user_trip.user)
    end

    if @trip.save
      respond_with @trip, location: [:admin, @trip]
    else
      render 'new'
    end
  end

  def edit
    authorize! :update, Trip

    @trip = Trip.find(params[:id])
  end

  def update
    authorize! :update, Trip

    @trip = Trip.find(params[:id])
    @trip.update_attributes(trip_params)
    respond_with @trip, location: [:admin, @trip]
  end

  def destroy
    authorize! :destroy, Trip

    @trip = Trip.find(params[:id])
    @trip.destroy
    redirect_to admin_trips_path
  end

  private

  def trip_params
    params.require(:trip).permit(
      :description, :value,
      user_ids: []
    )
  end
end
