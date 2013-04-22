
#codigo para modificar el pdf donde le puedo cambiar la imagen el texto de inicio
#y lo que deceo mostar en pdf

class HorarioPdf < Prawn::Document

 def initialize(horario,view)
       super()
       @horario = horario
       @view = view
       logo
       deliver_details
       horario_details
 end

 def logo
       logopath ="#{Rails.root}/app/assets/images/pdf.png"
       image logopath, :width => 50,:heigth => 20
       move_down 10
       draw_text "PDF",:at => [150,650],size:30
 end


 def deliver_details
   move_down 60
   text "Horario Del Curso:
  #{@horario.curso.nombre} ", :size => 13
 end

       def horario_details
               move_down 60
               fecha = @horario.fecha
               hora = @horario.hora
               aula = @horario.aula
               materia = @horario.materia.nombre
               instructor = @horario.instructor.nombre
               curso = @horario.curso.nombre
               table ([["Fecha","#{fecha}"],
                       ["Hora","#{hora}"],
                       ["Aula","#{aula}"],
                       ["Materia","#{materia}"],
                       ["instructor","#{instructor}"],
                       ["Curso","#{curso}"],
               ]),
               :width => 500 do
                       columns(1).align = :center
                       self.header = true
                       self.column_widths = {0 => 100, 2 => 50}
                       columns(3).font_style = :bold
               end        
       end
end