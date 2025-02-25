using { aldi.cap.galactic_spacefarer_adventure  as my } from '../db/schema';

service SpacefarerService @(requires:'authenticated-user', path: '/spacefarers') { 
  entity Spacefarers as projection on my.Spacefarers {*,
	 	origin_planet.name as origin_planet_name,
		@readonly
		spacesuit.color as spacesuit_color,
			
    first_name || ' ' ||last_name as full_name : String
	};

	entity Departments as projection on my.Departments;
	entity Positions as projection on my.Positions;
	entity Spacesuits as projection on my.Spacesuits;
}