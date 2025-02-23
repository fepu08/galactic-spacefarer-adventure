using { managed, cuid } from '@sap/cds/common';
namespace galactic_spacefarer_adventure;

type SpacesuitType : String enum {
    Engineer = 'engineer';
    Armored  = 'armored';
    Explorer  = 'explorer';
}

@assert.unique : {
   email: [ email ]
}
entity Spacefarers : managed, cuid {
	position: Association to Positions;
	department: Association to Departments;
	spacesuit: Association to Spacesuits;
	origin_planet: Association to Planets;
	skills: Composition of many Spacefarerskills on skills.spacefarer = $self;
	stardusts: Composition of many Spacefarerstardusts on stardusts.spacefarer = $self;

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
}

@assert.unique  : {
	title: [ title ]
}
entity Departments: cuid {
	@mandatory title: String;
}

entity Spacesuits: cuid {
	@mandatory type: SpacesuitType;
	@mandatory color: String(6);
}

@assert.unique  : {
	name: [ name ]
}
entity Planets: cuid {
	@mandatory name: String;
}

@assert.unique  : {
	name: [ name ]
}
entity Stardusts: cuid {
	@mandatory name: String;
	spacefarers: Composition of many Spacefarerstardusts on spacefarers.stardust = $self;
}

@assert.unique  : {
	title: [ title ]
}
entity Skills: cuid {
	@mandatory title: String;
	spacefarers: Composition of many Spacefarerskills on spacefarers.skill = $self;
	description: String;
}

entity Spacefarerskills: cuid, managed {
	@mandatory spacefarer: Association to Spacefarers;
	@mandatory skill: Association to Skills;
	@assert.range: [0,10]
	proficiency: UInt8 default 0;
}

entity Spacefarerstardusts: cuid, managed {
	@mandatory spacefarer: Association to Spacefarers;
	@mandatory stardust: Association to Stardusts;
	quantity: Integer
}