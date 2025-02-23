sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'galacticspacefareradventure/spacefarers/test/integration/FirstJourney',
		'galacticspacefareradventure/spacefarers/test/integration/pages/SpacefarersList',
		'galacticspacefareradventure/spacefarers/test/integration/pages/SpacefarersObjectPage',
		'galacticspacefareradventure/spacefarers/test/integration/pages/StardustCollectionsObjectPage'
    ],
    function(JourneyRunner, opaJourney, SpacefarersList, SpacefarersObjectPage, StardustCollectionsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('galacticspacefareradventure/spacefarers') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheSpacefarersList: SpacefarersList,
					onTheSpacefarersObjectPage: SpacefarersObjectPage,
					onTheStardustCollectionsObjectPage: StardustCollectionsObjectPage
                }
            },
            opaJourney.run
        );
    }
);