import { Component, OnInit } from '@angular/core';
import { adverts, IAdverts } from 'src/app/utils/adverts';

@Component({
  selector: 'app-description',
  templateUrl: './description.component.html',
})
export class DescriptionPageComponent implements OnInit {

  adverts: IAdverts[] = adverts.advertsTypes();

  constructor() { }

  ngOnInit(): void {
  }

}
