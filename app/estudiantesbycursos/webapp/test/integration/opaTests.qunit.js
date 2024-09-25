sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'estudiantesbycursos/test/integration/FirstJourney',
		'estudiantesbycursos/test/integration/pages/EstudiantesByCursosList',
		'estudiantesbycursos/test/integration/pages/EstudiantesByCursosObjectPage'
    ],
    function(JourneyRunner, opaJourney, EstudiantesByCursosList, EstudiantesByCursosObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('estudiantesbycursos') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheEstudiantesByCursosList: EstudiantesByCursosList,
					onTheEstudiantesByCursosObjectPage: EstudiantesByCursosObjectPage
                }
            },
            opaJourney.run
        );
    }
);