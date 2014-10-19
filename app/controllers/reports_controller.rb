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
    @cases = Complaint.group('nature').count('id')
    @f = @cases['agresion fisica']
    @p = @cases['agresion psicologica']
    @report.name = "TIPO AGRESION"
    @report.date = Date.today
    @report.save
    @cases.each do |key, value|
      @result = Result.new
      @result.label = key.to_s
      @result.porcentage = value.to_s
      @result.report_id = @report.id
      @result.save
    end
    @resp = Result.where(:report_id => @report.id)
  end

  def second
    @report = Report.new
    @cases = Case.joins(:user).group('station_id').count('id')
    @a = @cases[1]
    @b = @cases[2]
    @c = @cases[3]
    @d = @cases[4]
    @e = @cases[5]
    @report.name = "CANTIDAD CASOS"
    @report.date = Date.today
    @report.save
    @cases.each do |key, value|
      @result = Result.new
      @result.label = key.to_s
      @result.porcentage = value.to_s
      @result.report_id = @report.id
      @result.save
    end
  end

  def third
    @report = Report.new
    @cases = Link.joins(:person).where('role = ?', 'Victima').group('gender').count('id')
    @f = @cases['Femenino']
    @m = @cases['Masculino']
    @report.name = "GENERO VICTIMAS"
    @report.date = Date.today
    @report.save
    @cases.each do |key, value|
      @result = Result.new
      @result.label = key.to_s
      @result.porcentage = value.to_s
      @result.report_id = @report.id
      @result.save
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
