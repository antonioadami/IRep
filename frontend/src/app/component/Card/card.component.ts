import { ModelAdvert } from './../../services/advert/Type/modelAdvert';
import { Component, Input, OnInit } from '@angular/core';
import { AdvertService } from 'src/app/services/advert/advert.service';

@Component({
  selector: 'rep-card',
  templateUrl: './card.component.html',
})
export class RepCardComponent implements OnInit {

 @Input() advert: ModelAdvert;

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
