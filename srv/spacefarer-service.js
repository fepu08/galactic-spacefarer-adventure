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
      const { spacesuit_color, spacesuit_ID } = req;
      if (spacesuit_color && spacesuit_ID) {
        await this.updateSpacesuitColor(spacesuit_color, spacesuit_ID);
      }
      await this.sendWelcomeEmail(
        req.email,
        `${req.first_name} ${req.last_name}`
      );
    });

    this.on('UPDATE', this.Spacefarers, async (req) => {
      const { spacesuit_color, spacesuit_ID, ...spacefarer } = req.data;
      try {
        if (spacesuit_color && spacesuit_ID) {
          this.updateSpacesuitColor(spacesuit_color, spacesuit_ID);
        }

        await this.updateSpacefarer(spacefarer);
      } catch (error) {
        console.error(`Error during updating spacefarer: ${error}`);
      }
    });

    return super.init();
  }

  async updateSpacefarer(spacefarer) {
    await cds.run(
      UPDATE(this.Spacefarers)
        .set({
          first_name: spacefarer.first_name,
          last_name: spacefarer.last_name,
          birthday: spacefarer.birthday,
          stardust_collection: spacefarer.stardust_collection,
          email: spacefarer.email,
          wormhole_navigation_skill: spacefarer.wormhole_navigation_skill,
        })
        .where({ ID: spacefarer.ID })
    );
  }

  async updateSpacesuitColor(spacesuit_color, spacesuit_ID) {
    if (spacesuit_color && spacesuit_ID) {
      await cds.run(
        UPDATE(this.Spacesuits)
          .set({ color: spacesuit_color })
          .where({ ID: spacesuit_ID })
      );
    }
  }

  enhanceWormholeNavigationSkill(wormhole_navigation_skill) {
    if (wormhole_navigation_skill < 5) {
      console.log('Watching wormhole navigation tutorials on SpaceTube...');
      return 5;
    }

    return wormhole_navigation_skill;
  }

  enhanceStarDustCollection(stardusts) {
    if (stardusts < 1000) {
      console.log('Collecting stardusts...');
      return 1000;
    }
    return stardusts;
  }

  async getAvailableSuit() {
    const availableSuit = await cds.db.run(
      SELECT.one.from(this.Spacesuits)
        .where`ID NOT IN (SELECT spacesuit_ID FROM ${this.Spacefarers})`
    );

    return availableSuit;
  }

  async sendWelcomeEmail(toEmail, name) {
    const emailConfig = cds.env.requires.emailConfig;
    if (!emailConfig) {
      throw new Error('No Email config set.');
    }
    const transporter = nodemailer.createTransport(emailConfig);

    const mailOptions = {
      from: 'Spacefarers',
      to: toEmail,
      subject: 'Welcome to Spacefarers',
      text: `Congratulation ${name}! Your adventure begins now.`,
    };

    try {
      await transporter.sendMail(mailOptions);
      console.log(`Email sent to ${toEmail}`);
    } catch (error) {
      console.error('Error sending email:', error);
    }
  }
}

module.exports = { SpacefarerService };
