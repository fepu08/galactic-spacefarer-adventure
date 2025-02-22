const cds = require('@sap/cds');

class SpacefarerService extends cds.ApplicationService {
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
      const { skills } = req.data;
      const updatedSkills = this.enhanceWormholeNavigationSkill(skills);
      const availableSuit = await this.getAvailableSuit(
        Spacefarers,
        Spacesuits
      );

      if (!availableSuit) {
        req.error(
          400,
          'No available spacesuits. Please add more suits before creating a spacefarer.'
        );
        return;
      }

      req.data.spacesuit_ID = availableSuit.ID;
      req.data.skills = updatedSkills;
    });

    return super.init();
  }

  enhanceWormholeNavigationSkill(skills) {
    const wormholeNavigationSkillId = '0efd6e5f-1811-499d-9924-c89699ac7dda';
    const wormholeNavigationSkill = skills.find(
      (skill) => skill.skill_ID === wormholeNavigationSkillId
    ) ?? { skill_ID: wormholeNavigationSkillId, proficiency: 0 };

    while (wormholeNavigationSkill.proficiency < 5) {
      console.log('Watching a tutorial about Wormhole Navigation...');
      ++wormholeNavigationSkill.proficiency;
    }

    return (
      skills
        .map((skill) =>
          skill.skill_ID === wormholeNavigationSkill
            ? wormholeNavigationSkill
            : skill
        )
        // add skill if it does not exist
        .concat(
          skills.some((skill) => skill.skill_ID === wormholeNavigationSkillId)
            ? []
            : [wormholeNavigationSkill]
        )
    );
  }

  async getAvailableSuit(Spacefarers, Spacesuits) {
    const availableSuit = await cds.db.run(
      SELECT.one.from(Spacesuits)
        .where`ID NOT IN (SELECT spacesuit_ID FROM ${Spacefarers})`
    );

    return availableSuit;
  }
}

module.exports = { SpacefarerService };
