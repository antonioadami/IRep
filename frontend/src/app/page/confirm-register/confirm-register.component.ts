import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { NotificationService } from 'src/app/services/toastr/toastr.service';

@Component({
  selector: 'app-confirm-register',
  templateUrl: './confirm-register.component.html',
})
export class ConfirmRegisterComponent implements OnInit {

  confirmForm: FormGroup;

  constructor(
    private _formBuilder: FormBuilder,
    private _route:Router,
    private _toast: NotificationService,
  ) { }

  ngOnInit(): void {
    this.confirmForm = this._formBuilder.group({
      code: ['', [Validators.required]],
    });
  }

  public confirmCode(): void {
    this._toast.showSuccess('Código validado','Success');
    this._route.navigate(['/Irep/login'])
  }

}
