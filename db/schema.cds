using { managed, cuid } from '@sap/cds/common';
namespace aldi.cap.galactic_spacefarer_adventure;

type SpacesuitType : String enum {
    Engineer = 'engineer';
    Armored  = 'armored';
    Explorer  = 'explorer';
}
@assert.unique  : {
	spacesuit: [ spacesuit ]
}
entity Spacefarers : managed, cuid {
	position: Association to Positions;
	department: Association to Departments;
	spacesuit: Association to Spacesuits;
	origin_planet: Association to Planets;
	@assert.range: [0,10]
	wormhole_navigation_skill: UInt8 default 0;
	@assert.range: [0,1000000]
	stardust_collection: Integer default 0;

	@mandatory first_name: String;
	@mandatory last_name: String;
	nick_name: String;
	@mandatory birthday: Date;
	@mandatory email: String;
}

@assert.unique  : {
	title: [ title ]
}
entity Positions: cuid {
	@mandatory title: String;
	@mandatory min_salary: Decimal(10,2);
	@mandatory max_salary: Decimal(10,2);
	spacefarers: Association to many Spacefarers on spacefarers.position = $self
}

@assert.unique  : {
	title: [ title ]
}
entity Departments: cuid {
	@mandatory title: String;
	spacefarers: Association to many Spacefarers on spacefarers.department = $self
}

entity Spacesuits: cuid {
	@mandatory type: SpacesuitType;
	@assert.format: '^[0-9a-fA-F]{6}$'
	@mandatory color: String(6);
}

@assert.unique  : {
	name: [ name ]
}
entity Planets: cuid {
	@mandatory name: String;
}