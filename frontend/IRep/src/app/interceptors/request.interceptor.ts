import { Injectable } from '@angular/core';
import { HttpInterceptor, HttpRequest, HttpHandler, HttpEvent } from '@angular/common/http';
import { Observable } from 'rxjs';

const key = 'authToken';
//Envia o token para o servidor automaticamente

@Injectable()
export class requestInterceptor implements HttpInterceptor{

    constructor(){}

    intercept(req: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {



      const Token = window.localStorage.getItem(key);


        if(!!Token) {
            req = req.clone({
                setHeaders: {
                    'authorization': `Bearer ${Token}`
                }
            })
        }

        return next.handle(req);
    }

}
