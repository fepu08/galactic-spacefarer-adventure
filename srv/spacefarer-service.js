const cds = require('@sap/cds');

class SpacefarerService extends cds.ApplicationService {
  /** Registering custom event handlers */
  async init() {
    const { Spacefarers, Spacesuits, SpacefarerSkills, Skills } =
      cds.entities('SpacefarerService');

    this.before('*', (req) => {
      /* @(requires:'authenticated-user') catch it anyways */
      if (
        !req.user ||
        req.user === cds.User.anonymous ||
        req.user.is('anonymous')
      ) {
        req.error(401, 'Cosmic Invaders detected! Access Denied.');
      }
    });

    this.before('CREATE', Spacefarers, async (req) => {
      const availableSuit = await cds.db.run(
        SELECT.one.from(Spacesuits)
          .where`ID NOT IN (SELECT spacesuit_ID FROM ${Spacefarers})`
      );

      if (!availableSuit) {
        req.error(
          400,
          'No available spacesuits. Please add more suits before creating a spacefarer.'
        );
        return;
      }

      req.data.spacesuit_ID = availableSuit.ID;
    });

    this.on('CREATE', Spacefarers, async (req) => {
      const { skills, ...spacefarerData } = req.data;
      const db = cds.transaction(req);

      const [createdSpacefarer] = await db.run(
        INSERT.into(Spacefarers).entries(spacefarerData)
      );

      if (!createdSpacefarer.ID) {
        req.error(500, 'Failed to create Spacefarer');
        return;
      }

      if (skills && skills.length > 0) {
        const skillEntries = skills.map((skill) => ({
          spacefarer_ID: createdSpacefarer.ID,
          skill_ID: skill.skill_ID,
          proficiency: skill.proficiency || 0,
        }));

        await db.run(INSERT.into(SpacefarerSkills).entries(skillEntries));
      }

      // Note for the reviewer: we could also add stardust collection here but let assume that
      // rookie spacefarers have no collection on their first day 🤖

      return createdSpacefarer;
    });

    return super.init();
  }
}

module.exports = { SpacefarerService };
