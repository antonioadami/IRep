import { Component, OnInit } from '@angular/core';
import { adverts, IAdverts } from 'src/app/utils/adverts';

@Component({
  selector: 'app-favorites',
  templateUrl: './favorites.component.html',
})
export class FavoritesPageComponent implements OnInit {

  adverts: IAdverts[] = adverts.advertsTypes();

  constructor() { }

  ngOnInit(): void {
  }

}
