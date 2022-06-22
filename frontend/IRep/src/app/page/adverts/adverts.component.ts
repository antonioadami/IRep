import { adverts, IAdverts } from './../../utils/adverts';
import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-adverts',
  templateUrl: './adverts.component.html',
})
export class AdvertsPageComponent implements OnInit {

  adverts: IAdverts[] = adverts.advertsTypes();

  constructor() { }

  ngOnInit(): void {
  }

}
