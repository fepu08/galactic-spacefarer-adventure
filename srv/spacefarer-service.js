const cds = require('@sap/cds');
const nodemailer = require('nodemailer');

class SpacefarerService extends cds.ApplicationService {
  constructor(...args) {
    super(...args);
    const entries = cds.entities('SpacefarerService');
    this.Spacefarers = entries.Spacefarers;
    this.Spacesuits = entries.Spacesuits;
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
      const availableSuit = await this.getAvailableSuit();
      if (!availableSuit) {
        req.error(
          400,
          'No available spacesuits. Please add more suits before creating a spacefarer.'
        );
        return;
      }

      const { wormhole_navigation_skill, stardust_collection } = req.data;
      const enhancedSkill = this.enhanceWormholeNavigationSkill(
        wormhole_navigation_skill ?? 0
      );
      const enhancedStardustCollection = this.enhanceStarDustCollection(
        stardust_collection ?? 0
      );

      req.data.spacesuit_ID = availableSuit.ID;
      req.data.wormhole_navigation_skill = enhancedSkill;
      req.data.stardust_collection = enhancedStardustCollection;
    });

    this.after('CREATE', this.Spacefarers, async (req) => {
      try {
        await this.sendEmail(req.email, `${req.first_name} ${req.last_name}`);
        console.log(`Email sent to ${req.email}`);
      } catch (error) {
        console.error('Error sending email:', error);
      }
    });

    return super.init();
  }

  enhanceWormholeNavigationSkill(wormhole_navigation_skill) {
    if (wormhole_navigation_skill < 5) {
      console.log('Watching wormhole navigation tutorials on SpaceTube...');
    }

    return 5;
  }

  enhanceStarDustCollection(stardusts) {
    if (stardusts < 1000) {
      console.log('Collecting stardusts...');
    }
    return 1000;
  }

  async getAvailableSuit() {
    const availableSuit = await cds.db.run(
      SELECT.one.from(this.Spacesuits)
        .where`ID NOT IN (SELECT spacesuit_ID FROM ${this.Spacefarers})`
    );

    return availableSuit;
  }

  sendEmail(to, name) {
    const emailConfig = cds.env.requires.emailConfig;
    if (!emailConfig) {
      throw new Error('No Email config set.');
    }
    const transporter = nodemailer.createTransport(emailConfig);

    const mailOptions = {
      from: 'Spacefarers',
      to,
      subject: 'Welcome to Spacefarers',
      text: `Congratulation ${name}! Your adventure begins now.`,
    };

    return transporter.sendMail(mailOptions);
  }
}

module.exports = { SpacefarerService };
