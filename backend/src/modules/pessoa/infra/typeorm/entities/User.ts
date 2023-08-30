import { Entity, Column, PrimaryGeneratedColumn } from 'typeorm';

@Entity()
export default class User {
    @PrimaryGeneratedColumn('uuid')
    id: string;

    @Column()
    cpf: string;

    @Column()
    name: string;

    @Column()
    birthday: Date;

    @Column()
    email: string;

    @Column()
    phone: string;

    @Column({ type: 'varchar', nullable: true })
    avatarUrl: string | null;
}
