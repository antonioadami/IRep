import { Entity, Column, PrimaryGeneratedColumn } from 'typeorm';

@Entity()
export default class Realty {
    @PrimaryGeneratedColumn('uuid')
    id: string;

    @Column('json', { default: {} })
    features: unknown;

    @Column()
    neighborhood: string;

    @Column()
    city: string;

    @Column()
    street: string;

    @Column()
    number: string;

    @Column()
    zipCode: string;

    // @Column()
    // images: string[];
}
