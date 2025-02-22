using { galactic_spacefarer_adventure as my } from '../db/schema';

service SpacefarerService @(requires:'authenticated-user', path: '/spacefarers') { 
  entity Spacefarers as projection on my.Spacefarers {*,
		//position.title as position,
		department.title as department_title,
		spacesuit.color as spacesuit_color
	};

	entity SpacefarerSkills as projection on my.Spacefarerskills  {*,
		CONCAT(spacefarer.first_name, ' ', spacefarer.last_name) as spacefarer_full_name,
		skill.title as skill_title,
		proficiency
	}

	entity Skills as projection on my.Skills;
  
  entity StardustCollections as projection on my.Spacefarerstardusts  {*,
		CONCAT(spacefarer.first_name, ' ', spacefarer.last_name) as spacefarer_full_name,
		stardust.name as starudst
	}

	entity Spacesuits as projection on my.Spacesuits;
}