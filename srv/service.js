const cds = require('@sap/cds')
const { SELECT, INSERT, UPDATE, DELETE } = cds.ql
module.exports = cds.service.impl(function () {
    this.before(['CREATE', 'UPDATE'], 'Estudiantes', function (req) {
        console.log('Estudiantes called' + req);
        if (req.data && !req.data.Nombre) {
            req.error(400, 'Error - El nombre debe ser ingresado')
        }

    })

    this.before(['CREATE', 'UPDATE'], 'Cursos', function (req) {
        console.log('Cursos called' + req);
        if (req.data && !req.data.Nombre) {
            req.error(400, 'Error - El nombre debe ser ingresado')
        }
        if (req.data && req.data.MaxEstudiantes > 30) {
            req.error(400, 'Error - El curso tiene que ser de maximo 15')
        }
    })

    this.on('notificaAlumno', async function (req) {
        console.log("Notificacion alumno");
        let id;
        let alumnos;
        let query;
        let Nombre;
        let status;
        let curso_ID;
        let cursos;
        let cursos_nombres;
        const params = req.params;

        let adms = await cds.connect.to('AdminService');
        for (let i = 0; i < params.length; i++) {
            if (params != null) {
                id = params[i].ID;
                console.log('ID: ' + id);
                query = SELECT`ID, Nombre, DtAniversario,curso,status`.from`Estudiantes`.where`ID = ${id}`;
                alumnos = await adms.run(query);
                if (alumnos) {
                    Nombre = alumnos[0].Nombre;
                    curso_ID = alumnos[0].curso_ID;
                    status = alumnos[0].status;
                }
                query = SELECT`ID, Nombre`.from`Cursos`.where`ID = ${curso_ID}`;
                cursos = await adms.run(query);
                if (cursos) {
                    cursos_nombres = cursos[0].Nombre;
                }
                console.log(Nombre + " " + curso_ID);
                req.info(400, "Alumno " + id + " " + Nombre + " Cursando: " + cursos_nombres + " Status: " + status + " notificado con exito")
            }
        }
    })

    this.after('READ', 'Estudiantes', function (data) {
        const alumnos = Array.isArray(data) ? data : [data];

        alumnos.forEach((alumnos) => {
            switch (alumnos.status) {
                case 'A':
                    alumnos.critico = 3;
                    break;
                case 'I':
                    alumnos.critico = 2;
                    break;
                case 'P':
                    alumnos.critico = 1;
                    break;
                default:
                    break;
            }
        })
    })
    this.on('inactivaAlumno', async function(req){
        console.log("Inactivar Alumno");
        const {Estudiantes} = this.entities;

        const params = req.params;
        if(params != null){
            for(let i=0; i < params.length; i++){
                if(params[i].ID != null){
                    await UPDATE.entity(Estudiantes,params[i].ID)
                    .set({status:'I',comentario:req.data.text});
                    console.log('ID: '+params[i].ID + ' - Status: '+params[i].status);
                    req.info(400,'Alumno: '+ params[i].ID + ' ' +req.data.text + ' Status actualizado con exito')
                }
            }
        }
    })
}

)
