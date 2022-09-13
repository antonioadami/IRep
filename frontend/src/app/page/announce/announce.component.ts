import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { AdvertService } from 'src/app/services/advert/advert.service';

@Component({
  selector: 'app-announce',
  templateUrl: './announce.component.html',
})
export class AnnouncePageComponent implements OnInit {

  createForm: FormGroup;

  constructor(
    private _formBuilder: FormBuilder,
    private _route:Router,
    private _advert: AdvertService,
  ) { }

  ngOnInit(): void {
    this.createForm = this._formBuilder.group({
      nome: ['Anuncio 5', [Validators.required]],
      rua: ['', [Validators.required]],
      cidade: ['', [Validators.required]],
      bairro: ['', [Validators.required]],
      numero: ['', [Validators.required]],
      estado: ['', [Validators.required]],
      cep: ['', [Validators.required]],
      quartos: ['',],
      estacionamento: ['',],
      banheiros: ['',],
    })
  }

  createAdvert(): void {
    if(this.createForm.invalid){
      this.createForm.markAllAsTouched();
      return;
    }

    const nome = this.createForm.get('nome').value;
    const rua = this.createForm.get('rua').value;
    const cidade = this.createForm.get('cidade').value;
    const bairro = this.createForm.get('bairro').value;
    const numero = this.createForm.get('numero').value;
    const estado = this.createForm.get('estado').value;
    const cep = this.createForm.get('cep').value;
    const quartos = this.createForm.get('quartos').value;
    const estacionamento = this.createForm.get('estacionamento').value;
    const banheiros = this.createForm.get('banheiros').value;
    // const nome = this.createForm.get('nome').value;

    const endereco = {
      rua: rua,
      cidade: cidade,
      bairro: bairro,
      numero: numero,
      estado: estado,
      cep: cep,
    }

    const advert = {
      nome: nome,
      endereco: endereco,
      quartos: quartos,
      estacionamento: estacionamento,
      banheiros: banheiros,
      gas: false,
      internet: true,
    }

    this._advert.createAdvert(advert).subscribe( advert =>{
      console.log(advert);
    })

  }

}
