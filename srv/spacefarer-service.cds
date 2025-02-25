using { aldi.cap.galactic_spacefarer_adventure  as my } from '../db/schema';

service SpacefarerService @(requires:'authenticated-user', path: '/spacefarers') { 
  entity Spacefarers as projection on my.Spacefarers {*,
	 	origin_planet.name as origin_planet_name,
		spacesuit.color as spacesuit_color,
		department.title as department_title,
		position.title as position_title,
    first_name || ' ' ||last_name as full_name : String,
	};

	entity Departments as projection on my.Departments;
	entity Positions as projection on my.Positions;
	entity Spacesuits as projection on my.Spacesuits;

	annotate Spacefarers with @(restrict: [
    {
        grant: ['READ'],
        where: 'origin_planet_ID = $user.origin_planet_ID',
        to   : 'spacefarer'
    },
    {
        grant: ['*'],
        to   : 'admin'
    }
	])
}