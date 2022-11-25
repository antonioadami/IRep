import { Router } from '@angular/router';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { Component, OnInit } from '@angular/core';
import { PeopleService } from 'src/app/services/people/person.service';
import { ModelRegister } from 'src/app/services/people/Types/modelPerson';
import { NotificationService } from 'src/app/services/toastr/toastr.service';

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
    private _toast: NotificationService,
  ) { }

  ngOnInit() {
    this.registerForm = this._formBuilder.group({
      nome: ['', [Validators.required]],
      email: ['', [Validators.required, Validators.email]],
      senha: ['',[Validators.required]],
      cpf: ['',[Validators.required, Validators.maxLength(11), Validators.minLength(11)]],
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

    console.log('Register');

    this._toast.showSuccess('Codigo enviado','Success');
    return;
    this._person.createPerson(person)
      .subscribe({
        next: this.processNDRs.bind(this),
        error: this.processNDRsError.bind(this),
      })

  }

  private processNDRs(register: ModelRegister): void {
    console.log('Aqui');
    this._route.navigate(['/login']);
  }

  private processNDRsError(error: any): void {
    console.log('Error' + error.error.message);
    this._toast.showError(error.error.message, 'Error Register');
  }

}
