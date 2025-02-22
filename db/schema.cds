using { managed, cuid } from '@sap/cds/common';
namespace galactic_spacefarer_adventure;

type SpacesuitType : String enum {
    Engineer = 'engineer';
    Armored  = 'armored';
    Explorer  = 'explorer';
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
	@mandatory @assert.unique email: String;
}

entity Positions: cuid {
	@mandatory @assert.unique title: String;
	@mandatory min_salary: Decimal(10,2);
	@mandatory max_salary: Decimal(10,2);
}

entity Departments: cuid {
	@mandatory @assert.unique title: String;
}

entity Spacesuits: cuid {
	@mandatory type: SpacesuitType;
	@mandatory color: String(6);
}

entity Planets: cuid {
	@mandatory @assert.unique name: String;
}

entity Stardusts: cuid {
	@mandatory @assert.unique name: String;
	spacefarers: Composition of many Spacefarerstardusts on spacefarers.stardust = $self;
}

entity Skills: cuid {
	@mandatory @assert.unique title: String;
	spacefarers: Composition of many Spacefarerskills on spacefarers.skill = $self;
	description: String;
}

entity Spacefarerskills: cuid, managed {
	@mandatory spacefarer: Association to Spacefarers;
	@mandatory skill: Association to Skills;
	@assert.range: [1,10]
	proficiency: UInt8 default 1;
}

entity Spacefarerstardusts: cuid, managed {
	@mandatory spacefarer: Association to Spacefarers;
	@mandatory stardust: Association to Stardusts;
	quantity: Integer
}