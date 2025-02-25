using SpacefarerService as service from '../../srv/spacefarer-service';
using from '../../db/schema';

annotate service.Spacefarers with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'wormhole_navigation_skill',
                Value : wormhole_navigation_skill,
            },
            {
                $Type : 'UI.DataField',
                Label : 'stardust_collection',
                Value : stardust_collection,
            },
            {
                $Type : 'UI.DataField',
                Label : 'first_name',
                Value : first_name,
            },
            {
                $Type : 'UI.DataField',
                Label : 'last_name',
                Value : last_name,
            },
            {
                $Type : 'UI.DataField',
                Label : 'nick_name',
                Value : nick_name,
            },
            {
                $Type : 'UI.DataField',
                Label : 'birthday',
                Value : birthday,
            },
            {
                $Type : 'UI.DataField',
                Label : 'email',
                Value : email,
            },
            {
                $Type : 'UI.DataField',
                Label : 'origin_planet_name',
                Value : origin_planet_name,
            },
            {
                $Type : 'UI.DataField',
                Label : 'spacesuit_color',
                Value : spacesuit_color,
            },
            {
                $Type : 'UI.DataField',
                Label : 'department_title',
                Value : department_title,
            },
            {
                $Type : 'UI.DataField',
                Label : 'position_title',
                Value : position_title,
            },
            {
                $Type : 'UI.DataField',
                Label : 'full_name',
                Value : full_name,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Own Stardusts',
            ID : 'OwnStardusts',
            Target : 'stardusts/@UI.LineItem#OwnStardusts',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Skills',
            ID : 'Skills',
            Target : 'skills/@UI.LineItem#Skills',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'wormhole_navigation_skill',
            Value : wormhole_navigation_skill,
        },
        {
            $Type : 'UI.DataField',
            Label : 'stardust_collection',
            Value : stardust_collection,
        },
        {
            $Type : 'UI.DataField',
            Label : 'first_name',
            Value : first_name,
        },
        {
            $Type : 'UI.DataField',
            Label : 'last_name',
            Value : last_name,
        },
        {
            $Type : 'UI.DataField',
            Label : 'nick_name',
            Value : nick_name,
        },
    ],
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

annotate service.SpacefarerToStardust with @(
    UI.LineItem #OwnStardusts : [
        {
            $Type : 'UI.DataField',
            Value : stardust.title,
            Label : 'title',
        },
        {
            $Type : 'UI.DataField',
            Value : quantity,
            Label : 'quantity',
        },
        {
            $Type : 'UI.DataField',
            Value : stardust.rarity,
            Label : 'rarity',
        },
    ]
);

annotate service.SpacefarerToSkill with @(
    UI.LineItem #Skills : [
        {
            $Type : 'UI.DataField',
            Value : skill.title,
            Label : 'title',
        },
        {
            $Type : 'UI.DataField',
            Value : proficiency,
            Label : 'proficiency',
        },
    ]
);

