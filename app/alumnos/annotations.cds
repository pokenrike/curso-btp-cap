using AdminService as service from '../../srv/service';
annotate service.Estudiantes with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'Nombre',
                Value : Nombre,
            },
            {
                $Type : 'UI.DataField',
                Label : 'DtAniversario',
                Value : DtAniversario,
            },
            {
                $Type : 'UI.DataField',
                Value : email,
                Label : 'e-mail',
            },
            {
                $Type : 'UI.DataField',
                Value : Telefone,
                Label : 'Telefone',
            },
            {
                $Type : 'UI.DataField',
                Value : status,
                Label : 'status',
                Criticality : critico,
            },
            {
                $Type : 'UI.DataField',
                Value : critico,
                Label : 'critico',
            },
            {
                $Type : 'UI.DataField',
                Value : comentario,
                Label : 'comentario',
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'Detalle de Alumno',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'Nombre',
            Value : Nombre,
        },
        {
            $Type : 'UI.DataField',
            Label : 'DtAniversario',
            Value : DtAniversario,
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'AdminService.notificaAlumno',
            Label : 'Notifica Alumno',
        },
    ],
    UI.HeaderInfo : {
        Title : {
            $Type : 'UI.DataField',
            Value : Nombre,
        },
        TypeName : '',
        TypeNamePlural : '',
    },
    UI.Identification : [
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'AdminService.inactivaAlumno',
            Label : 'inactiva Alumno', ![@UI.Hidden] : {$edmJson: {$If: [
                {$Eq: [
                    {$Path: 'IsActiveEntity'},
                    false
                ]},
                true,
                false
            ]}}
        },
    ],
);

annotate service.Estudiantes with {
    curso @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'Cursos',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : curso_ID,
                ValueListProperty : 'ID',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'Nombre',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'MaxEstudiantes',
            },
        ],
    }
};

annotate service.Estudiantes with {
    critico @Common.FieldControl : #ReadOnly
};

annotate service.Estudiantes with {
    comentario @Common.FieldControl : #ReadOnly
};

