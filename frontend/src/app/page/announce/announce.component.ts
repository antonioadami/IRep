import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { AdvertService } from 'src/app/services/advert/advert.service';
import { ModelAdvert } from 'src/app/services/advert/Type/modelAdvert';
import { NotificationService } from 'src/app/services/toastr/toastr.service';

@Component({
  selector: 'app-announce',
  templateUrl: './announce.component.html',
})
export class AnnouncePageComponent implements OnInit {

  createForm: FormGroup;

  constructor(
    private _formBuilder: FormBuilder,
    private _route: Router,
    private _advert: AdvertService,
    private _toast: NotificationService,
  ) { }

  ngOnInit(): void {
    this.createForm = this._formBuilder.group({
      nome: ['Anuncio', [Validators.required]],
      rua: ['', [Validators.required]],
      cidade: ['', [Validators.required]],
      bairro: ['', [Validators.required]],
      numero: ['', [Validators.required]],
      estado: ['', [Validators.required]],
      cep: ['', [Validators.required]],
      quartos: ['',],
      estacionamento: ['',],
      banheiros: ['',],
      gas: ['',],
      internet: ['',],
    })
  }

  createAdvert(): void {
    if (this.createForm.invalid) {
      this.createForm.markAllAsTouched();
      return;
    }

    const endereco = {
      rua: this.createForm.get('rua').value,
      cidade: this.createForm.get('cidade').value,
      bairro: this.createForm.get('bairro').value,
      numero: this.createForm.get('numero').value,
      estado: this.createForm.get('estado').value,
      cep: this.createForm.get('cep').value,
    }

    const advert = {
      nome: this.createForm.get('nome').value,
      endereco: endereco,
      quartos: this.createForm.get('quartos').value,
      estacionamento: this.createForm.get('estacionamento').value,
      banheiros: this.createForm.get('banheiros').value,
      gas: this.createForm.get('gas').value,
      internet: this.createForm.get('internet').value,
    }

    this._advert.createAdvert(advert)
      .subscribe({
        next: this.advert.bind(this),
        error: this.advertError.bind(this),
      });

  }

  private advert(register: ModelAdvert): void {
    this._toast.showSuccess('Imóvel cadastrado', 'Success');
    this._route.navigate(['/Irep/dashboard'])
  }

  private advertError(error: any): void {
    console.log('Error' + error.error.message);
    this._toast.showError(error.error.message, 'Error');
  }

}
