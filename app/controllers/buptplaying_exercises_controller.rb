class BuptplayingExercisesController < ApplicationController
	def show
    @playingexercise = BuptplayingExercise.find_all_by_buptlesson_id(params[:lesson_id])
    render template: "buptexercises/show.json.rabl"
  end
end