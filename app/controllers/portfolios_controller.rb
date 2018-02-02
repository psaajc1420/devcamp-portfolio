class PortfoliosController < ApplicationController
  before_action :set_portfolio_item, only: [:edit, :show, :update, :destroy]
  access all: [:show, :index, :angular], user: {except: [:destroy, :new, :create, :update, :edit]}, site_admin: :all
  layout 'portfolio'

	def index
		@portfolio_items = Portfolio.all
	end

  def angular
    @angular_portfolio_items = Portfolio.angular
  end
  
	def new
		@portfolio_item = Portfolio.new
    3.times { @portfolio_item.technologies.build }
	end

	def create
    @portfolio_item = Portfolio.new(portfolio_params)
    respond_to do |format|
      if @portfolio_item.save
        format.html { redirect_to portfolios_path, notice: 'Portfolio was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def edit
  end

  def update

    respond_to do |format|
      if @portfolio_item = Portfolio.new(portfolio_params)
        format.html { redirect_to portfolios_path, notice: 'The record successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def show
  end

  def destroy

    # Destroy/delete the record
    @portfolio_item.destroy

    # Redirect
    respond_to do |format|
      format.html { redirect_to portfolios_url, notice: 'Record was removed.' }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_portfolio_item
      @portfolio_item = Portfolio.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def portfolio_params
      params.require(:portfolio).permit(:title,
                                        :subtitle,
                                        :body,
                                        technologies_attributes: [:name]
                                       )
    end

end
