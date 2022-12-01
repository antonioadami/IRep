import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { LoginService } from 'src/app/services/login/login.service';
import { NotificationService } from 'src/app/services/toastr/toastr.service';

const key = 'authToken';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
})
export class LoginComponent implements OnInit {

  loginForm: FormGroup;

  constructor(
    private _login: LoginService,
    private _formBuilder: FormBuilder,
    private _route: Router,
    private _toast: NotificationService,
  ) { }

  ngOnInit() {
    this.loginForm = this._formBuilder.group({
      email: ['', [Validators.required]],
      pass: ['', [Validators.required]]
    });
  }

  connectUser(): void {
    if (this.loginForm.invalid) {
      this.loginForm.markAllAsTouched();
      return;
    }
    const email = this.loginForm.get('email').value;
    const pass = this.loginForm.get('pass').value;

    const login = {
      usuario: email,
      senha: pass,
    }

    this._login.login(login)
    .subscribe({
      next: this.login.bind(this),
      error: this.loginError.bind(this),
    }
    )
  }

  private login(register: any): void {
    this._route.navigate(['/Irep/dashboard'])
    localStorage.setItem(key, register.token);
    this._toast.showSuccess(`Login feito `,'Success');
  }

  private loginError(error: any): void {
    this._toast.showError(error.error.message, 'Error');
  }

}
