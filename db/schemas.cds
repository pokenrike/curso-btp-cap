namespace capacitacion;

using { managed , cuid} from '@sap/cds/common';
// using { Attachments } from '@cap-js/attachments';


entity Alumnos : cuid, managed {
    key ID: UUID;
    Nombre: String @mandatory
                    @assert.format: '[a-zA-Z]+ [a-zA-Z]';
    DtAniversario: Date @mandatory;
        Telefone : String @assert.format: '[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]';
   email : String @assert.format: '[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]';
    status: String(1) @assert.range enum {A;I;P;};
    curso: Association to Cursos;
    critico: Integer;
 //   attachments: Composition of many Attachments;
    comentario: String;
}
entity Cursos : managed {
     key ID: UUID;
    Nombre: String @mandatory
                    @assert.format: '[a-zA-Z]+ [a-zA-Z]';
    MaxEstudiantes: Integer @mandatory
                             @assert.range:[0,30];
    estudiantes: Association to many Alumnos on estudiantes.curso = $self;
}