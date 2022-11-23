export interface IAdverts {
  id: number;
  image: string;
  name: string;
  address: string;
  city: string;
  neighborhood: string;
  number: number;
  description: string;
  numbers: string[];
  fav: boolean;
}

export class adverts {
  public static advertsTypes(): IAdverts[] {
    const advert = [
      {
        id: 1,
        image: '../../assets/imagens/1.jpg',
        name: 'Casa Azul',
        address: 'Rua Manoel Patta',
        neighborhood: 'Monte Belo',
        city: 'SRS',
        number: 464,
        description:
          '* 6 Quartos \n* 1 Suíte\n* 2 Banheiros\n* Piscina\n* Área de Churrasco\n * Cozinha\n* Salas\n',
        numbers: ['35 912884511', '35 9978718115'],
        fav: true,
      },
      {
        id: 2,
        image: '../../assets/imagens/2.jpg',
        name: 'Rep Doidão',
        address: 'Rua Barão',
        neighborhood: 'Monte Libano',
        city: 'SRS',
        number: 300,
        description:
          '* 6 Quartos \n* 1 Suíte\n* 4 Banheiros\n* Piscina\n* Área de Churrasco\n * Cozinha\n* Salas\n',
        numbers: ['35 912884511', '35 9978718115'],
        fav: true,
      },
      {
        id: 3,
        image: '../../assets/imagens/3.jpg',
        name: 'Rep Mineira',
        address: 'Rua Barão',
        neighborhood: 'Centro',
        city: 'Carmo de Minas',
        number: 492,
        description:
          '* 6 Quartos \n* 1 Suíte\n* 2 Banheiros\n* Piscina\n* Área de Churrasco\n * Cozinha\n* Salas\n',
        numbers: ['35 912884511', '35 9978718115'],
        fav: false,
      },
      {
        id: 4,
        image: '../../assets/imagens/4.jpg',
        name: 'Residencial Linha Azul',
        address: 'Rua da Pedra',
        neighborhood: 'Maristela',
        city: 'SRS',
        number: 150,
        description:
          '* 6 Quartos \n* 1 Suíte\n* 2 Banheiros\n* Piscina\n* Área de Churrasco\n * Cozinha\n* Salas\n',
        numbers: ['35 912884511', '35 9978718115'],
        fav: false,
      },
      {
        id: 5,
        image: '../../assets/imagens/5.jpg',
        name: 'Casa De Esquina',
        address: 'Rua Manoel Patta',
        neighborhood: 'Monte Belo',
        city: 'SRS',
        number: 464,
        description:
          '* 6 Quartos \n* 1 Suíte\n* 2 Banheiros\n* Piscina\n* Área de Churrasco\n * Cozinha\n* Salas\n',
        numbers: ['35 912884511', '35 9978718115'],
        fav: false,
      }
    ];

    return advert;
  }
}
