import winston from 'winston';
import env from './env';
import { emojify } from 'node-emoji';

const levels = {
  error: 0,
  warn: 1,
  info: 2,
  http: 3,
  graphql: 4,
  database: 5,
  debug: 6,
};

const colors = {
  error: 'red',
  warn: 'yellow',
  info: 'cyan',
  http: 'gray',
  graphql: 'magenta',
  database: 'white',
  debug: 'green',
};

const format = (convertEmojis: boolean = false, colorize: boolean = false) => {
  let format = winston.format.combine(
    winston.format((info) => {
      info.level = info.level.toUpperCase();

      if (convertEmojis) {
        info.message = emojify(info.message as string);
      }

      return info;
    })(),
    winston.format.timestamp({
      format: 'isoDateTime',
    })
  );

  if (colorize) {
    format = winston.format.combine(
      format,
      winston.format.colorize({ colors, all: true })
    );
  }

  return winston.format.combine(
    format,
    winston.format.printf(
      (info) => `${info.timestamp} ${info.level} ${info.message}`
    )
  );
};

const logger = winston.createLogger({
  levels,
  level: 'debug',
  format: format(false, false),
  transports: [
    new winston.transports.File({
      filename: 'error.log',
      level: 'error',
    }),
    new winston.transports.File({
      filename: 'combined.log',
    }),
  ],
});

if (!env.nodeEnv.production) {
  logger.add(
    new winston.transports.Console({
      format: format(true, true),
    })
  );
}

export default logger;
