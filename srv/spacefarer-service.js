const cds = require('@sap/cds');

class SpacefarerService extends cds.ApplicationService {
  constructor(...args) {
    super(...args);
    const entries = cds.entities('SpacefarerService');
    this.Spacefarers = entries.Spacefarers;
    this.Spacesuits = entries.Spacesuits;
    this.SpacefareSkills = entries.SpacefareSkills;
    this.Skills = entries.Skills;
    this.Stardusts = entries.Stardusts;
    this.wormholeNavigationIdCache = null;
  }

  async init() {
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

    this.before('CREATE', this.Spacefarers, async (req) => {
      const { skills, stardusts } = req.data;
      const updatedSkills = await this.enhanceWormholeNavigationSkill(skills);
      const updatedStardusts = await this.enhanceStarDustCollection(stardusts);
      const availableSuit = await this.getAvailableSuit();

      if (!availableSuit) {
        req.error(
          400,
          'No available spacesuits. Please add more suits before creating a spacefarer.'
        );
        return;
      }

      req.data.spacesuit_ID = availableSuit.ID;
      req.data.skills = updatedSkills;
      req.data.stardusts = updatedStardusts;
    });

    return super.init();
  }

  async getWormholeNavigationSkillId() {
    if (this.wormholeNavigationIdCache) {
      console.log('Cache Hit');
      return this.wormholeNavigationIdCache;
    }
    console.log('Cache Miss');
    let wormholeNavigationSkillId = null;
    const existingSkill = await cds.db.run(
      SELECT.one.from(this.Skills).where({ title: 'Wormhole Navigation' })
    );

    if (existingSkill) {
      console.log('Wormhole Navigation Skill exists');
      wormholeNavigationSkillId = existingSkill.ID;
    } else {
      console.log('Creating "Wormhole Navigation" skill');
      const [newSkill] = await cds.db.run(
        INSERT.into(this.Skills).entries({
          title: 'Wormhole Navigation',
        })
      );
      wormholeNavigationSkillId = newSkill.ID;
    }

    // Cache the ID to avoid unnecessary DB queries
    this.wormholeNavigationIdCache = wormholeNavigationSkillId;
    return this.wormholeNavigationIdCache;
  }

  async enhanceWormholeNavigationSkill(skills) {
    let wormholeNavigationSkillId = await this.getWormholeNavigationSkillId();

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

  async enhanceStarDustCollection(stardusts) {
    let collectionSize = stardusts
      ? stardusts.reduce((sum, item) => sum + item.quantity, 0)
      : 0;

    if (collectionSize >= 10) {
      console.log('Ready for adventure');
      return stardusts;
    }

    const randomStardust = await cds.db.run(
      SELECT.one.from(this.Stardusts).orderBy('RANDOM()')
    );

    const res = stardusts ?? [];
    res.push({
      stardust_ID: randomStardust.ID,
      quantity: 10 - collectionSize,
    });
    return res;
  }

  async getAvailableSuit() {
    const availableSuit = await cds.db.run(
      SELECT.one.from(this.Spacesuits)
        .where`ID NOT IN (SELECT spacesuit_ID FROM ${this.Spacefarers})`
    );

    return availableSuit;
  }
}

module.exports = { SpacefarerService };
