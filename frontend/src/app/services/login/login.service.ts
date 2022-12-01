import { Observable } from 'rxjs';
import { ModelLogin } from './Types/modelLogin';
import { environment } from './../../../environments/environment';
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';

const API_URL = environment.apiURL;
const key = 'authToken';

@Injectable({
  providedIn: 'root'
})
export class LoginService {

  constructor(
    private http: HttpClient,
  ) { }

  login(user: ModelLogin): Observable<any> {
    return this.http.post<any>(API_URL + 'auth/login', user);
  }

}
