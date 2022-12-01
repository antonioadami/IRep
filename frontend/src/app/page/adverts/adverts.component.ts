import { ModelAdvert } from './../../services/advert/Type/modelAdvert';
import { adverts, IAdverts } from './../../utils/adverts';
import { Component, OnInit } from '@angular/core';
import { AdvertService } from 'src/app/services/advert/advert.service';

@Component({
  selector: 'app-adverts',
  templateUrl: './adverts.component.html',
})
export class AdvertsPageComponent implements OnInit {

  advert: IAdverts[] = adverts.advertsTypes();

  adverts: ModelAdvert[] = [];

  constructor(
    private _advert: AdvertService,
  ) { }

  ngOnInit(): void {
    this._advert.getAdvert().subscribe(adverts => {
      this.adverts = adverts;
    })

  }

}
