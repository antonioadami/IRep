import { MigrationInterface, QueryRunner, Table } from 'typeorm';

export default class CreateRealty1693363088829 implements MigrationInterface {
    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.createTable(
            new Table({
                name: 'realty',
                columns: [
                    {
                        name: 'id',
                        type: 'uuid',
                        isPrimary: true,
                    },
                    {
                        name: 'features',
                        type: 'json',
                    },
                    {
                        name: 'neighborhood',
                        type: 'varchar',
                    },
                    {
                        name: 'city',
                        type: 'varchar',
                    },
                    {
                        name: 'street',
                        type: 'varchar',
                    },
                    {
                        name: 'number',
                        type: 'varchar',
                    },
                    {
                        name: 'zipCode',
                        type: 'varchar',
                    },
                ],
            }),
            true,
        );
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.dropTable('realty');
    }
}
