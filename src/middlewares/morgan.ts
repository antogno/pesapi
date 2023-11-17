import morgan from 'morgan';
import logger from '../config/logger';
import split from 'split';
import env from '../config/env';

const stream = split().on('data', function (line: string) {
	logger.log('http', line);
});

const skip = () => {
	return env.nodeEnv.production;
};

const morganMiddleware = morgan(
	':remote-addr - :remote-user [:date[clf]] ":method :url HTTP/:http-version" :status :res[content-length] ":referrer" ":user-agent" - :response-time ms',
	{ stream, skip }
);

export default morganMiddleware;
