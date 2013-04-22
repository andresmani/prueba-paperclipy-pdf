class EstudiantesController < ApplicationController
  require 'prawn'
  before_filter :find_curso_estudiantes
  helper_method :sort_column, :sort_direction

  def index
     @nrp = (params[:registro] != nil)? params[:registro].to_i : 3

     if ((@nrp) <= 0)
        @nrp = 3
    end
      @estudiantes = Estudiante.search(params[:search]).paginate(:per_page=>(@nrp), :page=>params[:page]).order(sort_column + " " + sort_direction)

     respond_to do |format|
       format.html 
       format.xml { render :xml => @estudiantes }
    end
 end

  def show
    @estudiante = Estudiante.find(params[:id])
  
  end

  def new
     @estudiante =  Estudiante.new
  end

  def edit
     
  end

  def create
      @estudiante = @curso.estudiante.build(params[:estudiante])
      render :action => :new unless @estudiante.save
      @estudiantes =Estudiante.all
  end

  def update
    render :action => :edit unless @estudiante.update_attributes(params[:estudiante])
  end

  def destroy
    @estudiante = Estudiante.find(params[:id])
      @estudiante.destroy
      @estudiantes =Estudiante.all
  end

  private

  def find_curso_estudiantes
     @curso = Curso.find(params[:curso_id])
     @estudiante = Estudiante.find(params[:id]) if params[:id]
  end


def sort_column
  Estudiante.column_names.include?(params[:sort]) ? params[:sort] : "nombre"
end

def sort_direction
  %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
end
 
end
