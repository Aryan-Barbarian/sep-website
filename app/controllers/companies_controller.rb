class CompaniesController < ApplicationController
  def index
  end

  def ventures
  	@companies = Company.where(isVenture: true)
  	@title = "Ventures"
  	render 'connections'
  end

  def connections
  	@companies = Company.all
  	@title = "Connections"
  end
end