using SpacefarerService as service from '../../srv/spacefarer-service';
annotate service.Spacefarers with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
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
                Label : 'department_title',
                Value : department_title,
            },
            {
                $Type : 'UI.DataField',
                Label : 'spacesuit_color',
                Value : spacesuit_color,
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
    ],
    UI.LineItem : [
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
    ],
);

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

