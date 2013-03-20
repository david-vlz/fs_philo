class CategoriesController < ApplicationController
	
	include CategoriesHelper
	before_filter :signed_in_user, except: [:show]

	def show
		@category = Category.find_by_id(params[:id])
		if @category && @category.single_page?
			@article = @category.articles.first
		elsif @category
			@articles = Article.where(category_id: @category.id).paginate(page: params[:page])
		end
	end

	def new
		@category = Category.new
	end

	def create
		@category = Category.new(params[:category])
		@category.precursor_id = Category.maximum('id')+1
		if @category && @category.save  \
		&& move_to_input_pos(@category, params[:category][:precursor_id]) 
			if @category.single_page?
				Article.create_in_succession( 
					title: @category.name, 
					body: 'Hier einfach weiterschreiben ;)', 
					category_id: @category.id,
					user_id: current_user.id
				)
			end
			flash[:success] = 'Seite erstellt!'
			redirect_to @category
		else
			flash[:error] = 'Da ist etwas schief gelaufen. Bitte kontaktiere einen Administrator'
			redirect_to new_category_path
		end
	end
	
	def edit
		@category = Category.find(params[:id])
	end
	
	
	def update
		@category = Category.find(params[:id])
		flash[:success] = ''
		if @category.insertion_attempt? params[:category][:precursor_id]
			move_to_input_pos(@category, params[:category][:precursor_id])
			flash[:success] += 'Beitrag verschoben! '.html_safe
		end
		if @category && @category.update_attributes(params[:category])
			flash[:success] << change_text
			flash[:success] = flash[:success].html_safe
			redirect_to @category
		else
			render 'edit'
		end
	end
	
	
end
