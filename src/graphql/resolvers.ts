import { resolvers } from '@generated/type-graphql';
import { Player, Nationality, Team } from '@generated/type-graphql';
import {
  Field,
  FieldResolver,
  Int,
  NonEmptyArray,
  ObjectType,
  Resolver,
  Root,
} from 'type-graphql';
import fs from 'fs';
import logger from '../config/logger';
import env from '../config/env';
import gm from 'gm';

/* eslint-disable @typescript-eslint/no-unused-vars */
@ObjectType('Image', {
  simpleResolvers: true,
})
export class Image {
  @Field((type) => String, {
    nullable: false,
  })
  url!: string;

  @Field((type) => Int, {
    nullable: false,
  })
  width!: number;

  @Field((type) => Int, {
    nullable: false,
  })
  height!: number;
}

@Resolver((of) => Player)
class PlayerImageResolver {
  @FieldResolver((type) => Image, { nullable: true })
  async picture(@Root() player: Player): Promise<Image | null> {
    const picture = await getImage('player', player.id, 'warn');
    return picture;
  }
}

@Resolver((of) => Nationality)
class NationalityImageResolver {
  @FieldResolver((type) => Image, { nullable: true })
  async flag(@Root() nationality: Nationality): Promise<Image | null> {
    const flag = await getImage('nationality', nationality.id);
    return flag;
  }
}

@Resolver((of) => Team)
class TeamImageResolver {
  @FieldResolver((type) => Image, { nullable: true })
  async logo(@Root() team: Team): Promise<Image | null> {
    let logo = await getImage('team', team.id);

    if (!logo) {
      const nationality = await prisma.nationality.findFirst({
        where: {
          name: team.name.replace(/^(Classic )+/, ''),
        },
      });

      if (nationality) {
        logo = await getImage('nationality', nationality.id);
      }
    }

    return logo;
  }
}
/* eslint-enable @typescript-eslint/no-unused-vars */

const getImage = (folder: string, id: number, logLevel: string = 'error') => {
  return new Promise<Image | null>((resolve) => {
    const path = `public/images/${folder}/${id}.png`;

    try {
      fs.accessSync(path, fs.constants.R_OK);

      const imageMagick = gm.subClass({ imageMagick: true });

      imageMagick(path).size(function (err, size) {
        if (!err) {
          const image = new Image();
          image.url = `http://localhost:${env.port}/${path}`;
          image.width = size.width;
          image.height = size.height;

          resolve(image);
        } else {
          logger.log(
            'error',
            `Could not get image size for ${folder} ID ${id}`
          );

          resolve(null);
        }
      });
      /* eslint-disable-next-line @typescript-eslint/no-unused-vars */
    } catch (err) {
      logger.log(logLevel, `Could not find image for ${folder} ID ${id}`);

      resolve(null);
    }
  });
};

/* eslint-disable-next-line @typescript-eslint/no-unsafe-function-type */
const combinedResolvers: NonEmptyArray<Function> = [
  Image,
  PlayerImageResolver,
  NationalityImageResolver,
  TeamImageResolver,
  ...resolvers,
];

export default combinedResolvers;
