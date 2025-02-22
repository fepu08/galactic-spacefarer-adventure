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

    return super.init();
  }
}

module.exports = { SpacefarerService };
