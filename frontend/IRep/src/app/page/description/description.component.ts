import { ModelAdvert } from './../../services/advert/Type/modelAdvert';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { AdvertService } from 'src/app/services/advert/advert.service';
import { adverts, IAdverts } from 'src/app/utils/adverts';

@Component({
  selector: 'app-description',
  templateUrl: './description.component.html',
})
export class DescriptionPageComponent implements OnInit {

  adverts: IAdverts[] = adverts.advertsTypes();
  advert: ModelAdvert;

  id: string;

  constructor(
    private _route: ActivatedRoute,
    private _advert: AdvertService,
  ) { }

  ngOnInit(): void {
    this._route.params.subscribe(id =>{
      this.id = id['advert'];
    });

    this._advert.advert(this.id).subscribe(advert => {
      this.advert = advert
      console.log(advert);
    })

  }

}
