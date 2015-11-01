class Admin::ProgramsController < ApplicationController
	def index
		@season = Season.find params[:season_id]
		@programs = @season.programs
	end

	def create
		json = params[:data]
		Program.new_from_json json, Season.find(params[:season_id])
		redirect_to :back
	end

	def edit
		@program = Program.find params[:id]
		@details = @program.details
	end

	def create_with_json
		json = params[:file]
		Program.insert_from_json json
		redirect_to :back
	end

	def update
		program = Program.find(params[:id])
		program.title = params[:program][:title]
		program.url = params[:program][:url]
		program.vote = params[:program][:vote]
		program.save
		redirect_to :back
	end

	def destroy
		program = Program.find(params[:id])
		program.destroy
		redirect_to :back
	end
end
