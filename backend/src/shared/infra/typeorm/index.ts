import { log } from 'console';
import { DataSource, DataSourceOptions } from 'typeorm';

const config: DataSourceOptions = {
    type: 'postgres',
    host: process.env.DATABASE_URI,
    port: parseInt(process.env.DATABASE_PORT as string, 10),
    username: process.env.DATABASE_USERNAME,
    password: process.env.DATABASE_PASSWORD,
    database: process.env.DATABASE_NAME,
    logging: false,
    synchronize: true,
    entities: ['./src/modules/**/infra/typeorm/entities/*.ts'],
    migrations: ['./src/shared/infra/typeorm/migrations/*.ts'],
};

log(config);

const connection = new DataSource(config);

connection
    .initialize()
    .then(() => {
        console.log(`Data Source has been initialized`);
    })
    .catch((err: unknown) => {
        console.error(`Data Source initialization error`, err);
    });
