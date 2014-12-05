class OperatingSystemsController < ApplicationController
	before_action :set_operating_system, only: [:edit, :update, :destroy]

	def index
		@operating_systems = OperatingSystem.all
	end

	def new
		@operating_system = OperatingSystem.new()
	end

	def edit
	end
	
	def create
		params = operating_system_safe_params
		@operating_system = OperatingSystem.new(params)
		if @operating_system.save
			redirect_to operating_systems_path, :notice => t('.success')
		else
			@operating_system.errors.add(:base, params.inspect) unless Rails.env.production?
			@operating_system.errors.add(:base, @operating_system.inspect) unless Rails.env.production?
			render action: 'new'
		end
	end

	def update
		params = operating_system_safe_params
		if @operating_system.update(params)
			redirect_to operating_systems_path, :notice => t('.success')
		else
			@operating_system.errors.add(:base, params.inspect) unless Rails.env.production?
			@operating_system.errors.add(:base, @operating_system.inspect) unless Rails.env.production?
			render action: 'edit'
		end
	end

	def destroy
		@operating_system.destroy
		redirect_to operating_systems_path, :notice => t('.success')
	end

	private
	def set_operating_system
		@operating_system = OperatingSystem.find_by_id(params[:id])
	end

	def operating_system_safe_params
		params.require(:operating_system).permit(:display_name, :cpe_name, :cpu_architecture)
	end
end
