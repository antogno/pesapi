import dotenv from 'dotenv';

dotenv.config();

const port = 4000;

const nodeEnv = {
  development: process.env.NODE_ENV === 'development',
  test: process.env.NODE_ENV === 'test',
  staging: process.env.NODE_ENV === 'staging',
  production: process.env.NODE_ENV === 'production',
};

const env = Object.freeze({ port, nodeEnv });

export default env;
