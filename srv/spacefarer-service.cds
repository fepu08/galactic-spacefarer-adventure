using { aldi.cap.galactic_spacefarer_adventure  as my } from '../db/schema';

service SpacefarerService @(requires:'authenticated-user', path: '/spacefarers') { 
  entity Spacefarers as projection on my.Spacefarers {*,
		spacesuit.color as spacesuit_color
	};

	entity Departments as projection on my.Departments;
	entity Positions as projection on my.Positions;
	entity Spacesuits as projection on my.Spacesuits;
}