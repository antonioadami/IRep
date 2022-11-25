import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { LoginService } from 'src/app/services/login/login.service';

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

    this._login.login(login);
    if (!!window.localStorage.getItem(key)) {
      this._route.navigate(['/Irep/dashboard'])
    }


  }

}
