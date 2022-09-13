import { LoginService } from './../../services/login/login.service';
import { Router } from '@angular/router';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { Component, OnInit } from '@angular/core';
import { PeopleService } from 'src/app/services/people/person.service';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
})
export class RegisterComponent implements OnInit {

  registerForm: FormGroup;

  constructor(
    private _formBuilder: FormBuilder,
    private _route:Router,
    private _person: PeopleService,
  ) { }

  ngOnInit() {
    this.registerForm = this._formBuilder.group({
      nome: ['', [Validators.required]],
      email: ['', [Validators.required]],
      senha: ['',[Validators.required]],
      cpf: ['',[Validators.required]],
      data: ['',[Validators.required]],
      telefone: ['',[Validators.required]],
    });
  }

  registerPerson(): void {
    if(this.registerForm.invalid){
      this.registerForm.markAllAsTouched();
      return;
    }

    const nome = this.registerForm.get('nome').value;
    const email = this.registerForm.get('email').value;
    const senha = this.registerForm.get('senha').value;
    const cpf = this.registerForm.get('cpf').value;
    const data = this.registerForm.get('data').value;
    const telefone = this.registerForm.get('telefone').value;


    const person = {
      nome: nome,
      email: email,
      senha: senha,
      cpf: cpf,
      dataNascimento: data,
      telefone: telefone,
    }

    this._person.createPerson(person)
      .subscribe(person => {
        console.log(person);
        if(person) this._route.navigate(['/login']);
      })

  }

}
