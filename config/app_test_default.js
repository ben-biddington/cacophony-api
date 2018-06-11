// A real test configuration
// @todo: consider readinf from env vars

const server = {
  passportSecret: "something",
  loggerLevel: "debug",
  http: {
    active: true,
    port: 1080,
  },
};

const s3 = {  // Used for storing audio & video recordings.
  publicKey: "REQUIRED",  // obtain from S3 server.
  privateKey: "REQUIRED", // obtain from S3 server
  bucket: "cacophony",
  endpoint: "http://localhost:9001",
};

const fileProcessing = {
  port: 2008,
};

// ======= Database settings =======
const database = {
  username: "test",
  password: "test",
  database: "cacophonytest",
  host: "localhost",
  dialect: "postgres"
};

exports.server = server;
exports.s3 = s3;
exports.fileProcessing = fileProcessing;
exports.database = database;

// This is needed because Sequelize looks for development by default
// when using db:migrate
exports.development = database;
