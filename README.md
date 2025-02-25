# Galactic Space Adventure

## Prerequisites

Ensure you have the following installed before running the project:

- [Node.js](https://nodejs.org/) (>= 14.x recommended)
- [npm](https://www.npmjs.com/) or [yarn](https://yarnpkg.com/)
- [SAP CDS Development Kit](https://cap.cloud.sap/docs/get-started/) (Install globally using `npm install -g @sap/cds`)

## 🚀 Setup and Run the Project (in development mode)

### 1️⃣ Clone the Repository

```sh
$ git clone https://github.com/fepu08/galactic-spacefarer-adventure.git
$ cd galactic-space-adventure
```

### 2️⃣ Install Dependencies

```sh
$ npm install
```

### 3️⃣ Create the `.env` File

To enable email notifications, you must create a `.env` file based on the `.env.example` file.

```sh
$ cp .env.example .env
```

Then, open `.env` and configure the email settings.

### 4️⃣ Start the CAP Server

```sh
$ cds watch
```

This will start the CAP service and automatically reload changes.

### Note
You can log in with the users listed in `package.json`. All have an empty password.
