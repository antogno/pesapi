import { PrismaClient } from '@prisma/client';
import env from '../config/env';
import logger from '../config/logger';

let prisma: PrismaClient;

declare global {
	/* eslint-disable-next-line no-var */
	var prisma: PrismaClient;
}

const createPrismaClient = () => {
	const prisma = new PrismaClient({
		log: [
			{
				emit: 'event',
				level: 'query',
			},
			{
				emit: 'event',
				level: 'error',
			},
			{
				emit: 'event',
				level: 'info',
			},
			{
				emit: 'event',
				level: 'warn',
			},
		],
	});

	prisma.$on('query', (e) => {
		logger.log('database', 'Query: ' + e.query);
		logger.log('database', 'Params: ' + e.params);
		logger.log('database', 'Duration: ' + e.duration + ' ms');
	});

	return prisma;
};

if (env.nodeEnv.production) {
	prisma = createPrismaClient();
} else {
	if (!global.prisma) {
		global.prisma = createPrismaClient();
	}

	prisma = global.prisma;
}

export default prisma;
