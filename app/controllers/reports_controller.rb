require 'rubygems'
require 'google_chart'

class ReportsController < ApplicationController
  before_action :set_report, only: [:show, :edit, :update, :destroy]

  def index
    @reports = Report.all
    respond_with(@reports)
  end
 
  def show
    respond_with(@report)
  end

  def new
    @report = Report.new
    @cases = Complaint.select("COUNT(complaints.id) AS total, *").group('nature')
    @report.name = "TIPO AGRESION"
    @report.date = Date.today
    if Date.today.day == 1
      @report.save
      @cases.each do |key, value|
        @result = Result.new
        @result.label = key.to_s
        @result.porcentage = value.to_s
        @result.report_id = @report.id
        @result.save
      end
    end
  end

  def second
    @report = Report.new
    @cases = Case.joins(:user).select("COUNT(cases.id) AS total, *").group('station_id')
    @report.name = "CANTIDAD CASOS"
    @report.date = Date.today
    if Date.today.day == 1
      @report.save
      @cases.each do |key, value|
        @result = Result.new
        @result.label = key.to_s
        @result.porcentage = value.to_s
        @result.report_id = @report.id
        @result.save
      end
    end
  end

  def third
    @report = Report.new
    @cases = Link.joins(:person).where('role = ?', 'Victima').select("COUNT(links.id) AS total, *").group('gender')
    @report.name = "GENERO VICTIMAS"
    @report.date = Date.today
    if Date.today.day == 1
      @report.save
      @cases.each do |key, value|
        @result = Result.new
        @result.label = key.to_s
        @result.porcentage = value.to_s
        @result.report_id = @report.id
        @result.save
      end
    end
  end

  def fourth
    @report = Report.new
   @cases = Link.joins(:person).where('role = ?', 'Agresor').select("COUNT(links.id) AS total, *").group('gender')
    @report.name = "GENERO AGRESOR"
    @report.date = Date.today
    if Date.today.day == 1
      @report.save
      @cases.each do |key, value|
        @result = Result.new
        @result.label = key.to_s
        @result.porcentage = value.to_s
        @result.report_id = @report.id
        @result.save
      end
    end
  end

  def edit
  end

  def create
    @report = Report.new(report_params)
    @report.save
  end

  def update

   
    @report.update(report_params)
    respond_with(@report)
  end

  def destroy
    @report.destroy
    respond_with(@report)
  end

  private
    def set_report
      @report = Report.find(params[:id])
    end

    def report_params
      params[:report]
    end
end
