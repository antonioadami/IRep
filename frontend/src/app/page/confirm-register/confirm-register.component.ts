import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { PeopleService } from 'src/app/services/people/person.service';
import { ModelCodeDelivery, ModelRegister } from 'src/app/services/people/Types/modelPerson';
import { NotificationService } from 'src/app/services/toastr/toastr.service';

@Component({
  selector: 'app-confirm-register',
  templateUrl: './confirm-register.component.html',
})
export class ConfirmRegisterComponent implements OnInit {

  confirmForm: FormGroup;

  constructor(
    private _formBuilder: FormBuilder,
    private _route: Router,
    private _toast: NotificationService,
    private _peopleService: PeopleService,
  ) { }

  ngOnInit(): void {
    this.confirmForm = this._formBuilder.group({
      email: ['', [Validators.required]],
      code: ['', [Validators.required]],
    });
  }

  public confirmCode(): void {

    if (this.confirmForm.invalid) {
      this.confirmForm.markAllAsTouched();
      return;
    }
    const email = this.confirmForm.get('email').value;
    const code = this.confirmForm.get('code').value;

    this._peopleService.confirmRegisterCode({email: email, code: code})
      .subscribe({
        next: this.successCode.bind(this),
        error: this.errorCode.bind(this),
      }
      )
  }

  private successCode(register: any): void {
    this._toast.showSuccess('Código validado', 'Success');
    this._route.navigate(['/login'])
  }

  private errorCode(error: any): void {
    this._toast.showError(error.error.message, 'Erro para validar código');
  }

  public resendCode(): void {
    if (this.confirmForm.get('email').invalid) {
      this.confirmForm.get('email').markAllAsTouched();
      return;
    }
    const email = this.confirmForm.get('email').value;

    this._peopleService.resendCode(email)
      .subscribe({
        next: this.successResend.bind(this),
        error: this.errorResend.bind(this),
      }
      )
  }

  private successResend(register: any): void {
    this._toast.showSuccess(`Código reenviado para ${register.CodeDeliveryDetails.Destination} `, 'Success');
  }

  private errorResend(error: any): void {
    this._toast.showError(error.error.message, 'Erro para reenviar código');
  }

}
