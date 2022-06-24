import { Component, EventEmitter, OnInit, Output } from '@angular/core';

@Component({
  selector: 'rep-header',
  templateUrl: './header.component.html',
})
export class RepHeaderComponent implements OnInit {

  open: boolean = true;

  @Output() openSide: EventEmitter<boolean> = new EventEmitter<boolean>();

  constructor() { }

  ngOnInit(): void {
  }

  closeOpenSide(): void {
    this.open = !this.open;
    this.openSide.emit(true)
  }
}
