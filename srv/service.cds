using { capacitacion, sap.common } from '../db/schemas';

service AdminService {
    type inText : {
       commmet: String;
        }
entity Estudiantes as projection on capacitacion.Alumnos actions {
@Common.IsActionCritical
action notificaAlumno();
@Common.IsActionCritical
action inactivaAlumno(text:inText:commmet);
}
 annotate Estudiantes with @odata.draft.enabled;
annotate Estudiantes with @odata.draft.bypass;   
entity Cursos as projection on capacitacion.Cursos;
annotate Cursos with @odata.draft.enabled;
annotate Cursos with @odata.draft.bypass;
}
annotate AdminService with @(requires:'admin');

service EstudiantesService {
 @readonly   
view EstudiantesByCursos as 
select from capacitacion.Cursos as CursosEstudiantes {
    key ID,
    Nombre,
    estudiantes.Nombre as NombreEstudiante,
    estudiantes.DtAniversario as DataAniversario
    }

}
annotate EstudiantesService with @(requires:'viewer');

annotate AdminService.inText:commmet with @Common.Label : 'Comentarios';
annotate AdminService.inText:commmet with @UI.MultiLineText:true;

