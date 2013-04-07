# coding: utf-8

require 'will_paginate/array'

class CategoriesController < ApplicationController
	
	include CategoriesHelper
	before_filter :signed_in_user, except: [:show]

	def show
		@category = Category.find_by_id(params[:id])
		if @category && @category.single_page?
			@article = @category.articles.first
		elsif @category
			articles = Article.where(category_id: @category.id)
			articles = articles.select { |a| a.visible? } unless signed_in?
			@articles = Article.subset_in_succession(articles).paginate(page: params[:page], per_page: 8)
			@condition = Proc.new { |article| article.category_id == @category.id }
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
					preview: "Das ist der erste Absatz deines Beitrags, der als Vorschau verwendet wird<br>",
					body: "^__^ <br><br>Das ist der Hauptteil neuen Beitrags! <br><br>Der ist zunächst für normale Benutzer unsichtbar, damit du ihn in Ruhe bearbeiten kannst. <br><br>Dafür benutze einfach den Bearbeiten Link oben rechts.".html_safe,
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


	def destroy
		@category = Category.find(params[:id])
		if @category.articles.each { |a| a.destroy_from_succession } \
		&& @category.destroy_from_succession
			flash[:success] = "Die Seite und alle verkn&uuml;pften Beitr&auml;ge wurden entfernt".html_safe
			redirect_to root_path
		else
			flash[:error] = 'Da ist etwas schief gelaufen. Bitte kontaktiere einen Administrator'
			redirect_to root_path
		end
	end
	
end
