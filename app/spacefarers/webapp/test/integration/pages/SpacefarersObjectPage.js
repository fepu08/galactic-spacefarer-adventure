sap.ui.define(['sap/fe/test/ObjectPage'], function(ObjectPage) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ObjectPage(
        {
            appId: 'aldi.cap.spacefarers',
            componentId: 'SpacefarersObjectPage',
            contextPath: '/Spacefarers'
        },
        CustomPageDefinitions
    );
});