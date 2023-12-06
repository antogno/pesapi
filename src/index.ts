import 'reflect-metadata';
import env from './config/env';
import logger from './config/logger';
import { buildSchema, emitSchemaDefinitionFile } from 'type-graphql';
import resolvers from './graphql/resolvers';
import { ApolloServer } from '@apollo/server';
import { Context, createContext } from './config/context';
import { GraphQLSchema } from 'graphql';
import morganMiddleware from './middlewares/morgan';
import apolloServerLogger from './lib/apolloServerLogger';
import fastify from 'fastify';
import fastifyApollo, {
  fastifyApolloDrainPlugin,
} from '@as-integrations/fastify';
import fastifyMiddie from '@fastify/middie';
import fastifyStatic from '@fastify/static';
import path from 'path';

const bootstrap = async () => {
  const schema = await buildSchema({ resolvers });

  const noMutationsSchema = new GraphQLSchema({
    query: schema.getQueryType(),
    subscription: schema.getSubscriptionType(),
  });

  await emitSchemaDefinitionFile(
    __dirname + '/graphql/schema.graphql',
    noMutationsSchema
  );

  const app = fastify();

  await app.register(fastifyMiddie);

  await app.register(fastifyStatic, {
    root: path.join(path.resolve(__dirname, '..'), '/public'),
    prefix: '/public',
    list: true,
    index: false,
  });

  const apollo = new ApolloServer<Context>({
    schema: noMutationsSchema,
    plugins: [fastifyApolloDrainPlugin(app), apolloServerLogger],
    introspection: !env.nodeEnv.production,
  });

  await apollo.start();

  await app.use(morganMiddleware);

  await app.register(fastifyApollo(apollo), {
    context: async () => createContext(),
  });

  app.listen({ port: env.port }, (err, address) => {
    if (err) {
      logger.log('error', err.message);
      throw err;
    }

    logger.log('info', `:rocket: Server ready at ${address}`);
  });
};

bootstrap();
