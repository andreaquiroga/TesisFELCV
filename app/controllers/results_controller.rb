class ResultsController < ApplicationController
  before_action :set_result, only: [:show, :edit, :update, :destroy]

  def index
    @results = Result.all
    respond_with(@results)
  end

  def show
    respond_with(@result)
  end

  def new
    @result = Result.new
    respond_with(@result)
  end

  def edit
  end

  def create
    @result = Result.new(result_params)
    @result.save
    respond_with(@result)
  end

  def update
    @result.update(result_params)
    respond_with(@result)
  end

  def destroy
    @result.destroy
    respond_with(@result)
  end

  private
    def set_result
      @result = Result.find(params[:id])
    end

    def result_params
      params[:result]
    end
end
