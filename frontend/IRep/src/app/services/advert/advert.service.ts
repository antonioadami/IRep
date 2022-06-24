import { ModelAdvert } from './Type/modelAdvert';
import { environment } from './../../../environments/environment';
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

const API_URL = environment.apiURL;

@Injectable({
  providedIn: 'root'
})
export class AdvertService {

  constructor(private http: HttpClient,) { }


  getAdvert(): Observable<ModelAdvert[]> {
    return this.http.get<ModelAdvert[]>(API_URL + 'imovel');
  }

}
