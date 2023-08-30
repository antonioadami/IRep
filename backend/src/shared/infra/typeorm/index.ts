import 'dotenv/config';
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

const PostgresDataSource = new DataSource(config);

PostgresDataSource.initialize();

export default PostgresDataSource;
