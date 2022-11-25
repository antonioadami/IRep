import { ModelPerson, ModelRegister } from './Types/modelPerson';
import { environment } from '../../../environments/environment';
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

const API_URL = environment.apiURL;

@Injectable({
  providedIn: 'root'
})
export class PeopleService {

  constructor(
    private http: HttpClient,
  ) {}

  createPerson(person: ModelPerson): Observable<ModelRegister> {
    return this.http.post<ModelRegister>(API_URL + 'pessoa', person);
  }

  confirmRegisterCode() {

  }
}
