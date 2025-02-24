using SpacefarerService as service from '../../srv/spacefarer-service';
annotate aldi.cap.galactic_spacefarer_adventure.Spacefarers with @fiori.draft.enabled;
annotate SpacefarerService.Spacefarers with @odata.draft.enabled;
annotate service.Spacefarers with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Firstname1}',
                Value : first_name,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Lastname1}',
                Value : last_name,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Stardustcollection1}',
                Value : stardust_collection,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Birthday1}',
                Value : birthday,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Email1}',
                Value : email,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Wormholenavigationskill1}',
                Value : wormhole_navigation_skill,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Spacesuitcolor1}',
                Value : spacesuit_color,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : '{i18n>GeneralInformation}',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Firstname}',
            Value : first_name,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Lastname}',
            Value : last_name,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Nickname}',
            Value : nick_name,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Stardustcollection}',
            Value : stardust_collection,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Wormholenavigationskill}',
            Value : wormhole_navigation_skill,
        },
        {
            $Type : 'UI.DataField',
            Value : spacesuit_color,
            Label : '{i18n>Spacesuitcolor}',
        },
        {
            $Type : 'UI.DataField',
            Value : department.title,
            Label : '{i18n>Departmenttitle}',
        },
        {
            $Type : 'UI.DataField',
            Value : position.title,
            Label : '{i18n>Positiontitle}',
        },
    ],
    UI.SelectionFields : [
        department.title,
        position.title,
        origin_planet_name,
    ],
    UI.HeaderInfo : {
        Title : {
            $Type : 'UI.DataField',
            Value : full_name,
        },
        TypeName : '',
        TypeNamePlural : '',
    },
);

annotate service.Spacefarers with {
    position @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'Positions',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : position_ID,
                ValueListProperty : 'ID',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'title',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'min_salary',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'max_salary',
            },
        ],
    }
};

annotate service.Spacefarers with {
    department @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'Departments',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : department_ID,
                ValueListProperty : 'ID',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'title',
            },
        ],
    }
};

annotate service.Spacefarers with {
    spacesuit @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'Spacesuits',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : spacesuit_ID,
                ValueListProperty : 'ID',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'type',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'color',
            },
        ],
    }
};

annotate service.Departments with {
    title @Common.Label : '{i18n>Departmenttitle}'
};

annotate service.Positions with {
    title @Common.Label : '{i18n>Positiontitle}'
};

annotate service.Spacefarers with {
    origin_planet_name @Common.Label : '{i18n>Originplanetname}'
};

