import logger from '../config/logger';
import { Context } from '../config/context';
import { ApolloServerPlugin } from '@apollo/server';

const apolloServerLogger: ApolloServerPlugin<Context> = {
  async requestDidStart(requestContext) {
    logger.log('graphql', `Query: ${requestContext.request.query}`);
    logger.log(
      'graphql',
      `Variables: ${JSON.stringify(
        requestContext.request.variables
          ? requestContext.request.variables
          : undefined
      )}`
    );
  },
};

export default apolloServerLogger;
