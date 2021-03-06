require 'paginator'

class ComparisonsController < ApplicationController
  
  def index
    @pager = Paginator.new(Comparison.count, 10) do |offset, per_page|
      Comparison.find(:all, :include => :results, :limit => per_page, :offset => offset)
    end
    @page = @pager.page(params[:page])
    respond_to do |format|
      format.html
      format.js do
        render :update do |page|
          page[:comparisons].reload
        end
      end
    end
  end
  
  def new
     @comparison = Comparison.new
  end
  
  def create
    @comparison = Comparison.create(params[:comparison])
    if @comparison.valid?
      redirect_to @comparison
    else
      render :action => :new
    end
  end
  
  def show
    @comparison = Comparison.find(params[:id], :include => :results)
  end
  
  def edit
    @comparison = Comparison.find(params[:id])
  end
  
  def update
    @comparison = Comparison.find(params[:id])
    if @comparison.update_attributes(params[:comparison])
      redirect_to @comparison
    else
      render :action => :edit
    end
  end
  
  def destroy
    @comparison = Comparison.find(params[:id])
    @comparison.destroy
    redirect_to comparisons_path
  end
  
end
