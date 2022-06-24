import { LoginService } from './../../services/login/login.service';
import { Router } from '@angular/router';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
})
export class RegisterComponent implements OnInit {

  registerForm: FormGroup;

  constructor(
    private _formBuilder: FormBuilder,
    private _route:Router,
  ) { }

  ngOnInit() {
    this.registerForm = this._formBuilder.group({
      nome: ['', [Validators.required]],
      email: ['', [Validators.required]],
      pass: ['',[Validators.required]]
    });
  }

}
