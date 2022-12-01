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

    const person = {
      nome: this.registerForm.get('nome').value,
      email: this.registerForm.get('email').value,
      senha: this.registerForm.get('senha').value,
      cpf: this.registerForm.get('cpf').value,
      dataNascimento: this.registerForm.get('data').value,
      telefone: this.registerForm.get('telefone').value,
    }

    this._person.createPerson(person)
      .subscribe({
        next: this.register.bind(this),
        error: this.registerError.bind(this),
      })

  }

  private register(register: ModelRegister): void {
    this._toast.showSuccess(`Código enviado para ${register.codeDeliveryDetails.Destination} `,'Success');
    this._route.navigate(['/confirm']);
  }

  private registerError(error: any): void {
    console.log('Error' + error.error.message);
    this._toast.showError(error.error.message, 'Error Register');
  }

}
