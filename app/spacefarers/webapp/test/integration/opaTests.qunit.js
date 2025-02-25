sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'aldi/cap/spacefarers/test/integration/FirstJourney',
		'aldi/cap/spacefarers/test/integration/pages/SpacefarersList',
		'aldi/cap/spacefarers/test/integration/pages/SpacefarersObjectPage'
    ],
    function(JourneyRunner, opaJourney, SpacefarersList, SpacefarersObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('aldi/cap/spacefarers') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheSpacefarersList: SpacefarersList,
					onTheSpacefarersObjectPage: SpacefarersObjectPage
                }
            },
            opaJourney.run
        );
    }
);