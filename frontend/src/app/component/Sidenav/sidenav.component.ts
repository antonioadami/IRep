import { Component, Input, OnInit, SimpleChange } from '@angular/core';

@Component({
  selector: 'rep-sidenav',
  templateUrl: './sidenav.component.html',
})
export class RepSidenavComponent implements OnInit {

  @Input() open: boolean = true;

  constructor() { }

  ngOnInit(): void {
  }

  ngOnchanges(changes: SimpleChange): void {
    if('open' in changes)
    console.log(open);

  }

}
