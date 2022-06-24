import { IAdverts } from './../../utils/adverts';
import { Component, Input, OnInit } from '@angular/core';

@Component({
  selector: 'rep-card',
  templateUrl: './card.component.html',
})
export class RepCardComponent implements OnInit {

 @Input()
  advert!: IAdverts;

  constructor() { }

  ngOnInit(): void {
    console.log(this.advert);
  }

}
