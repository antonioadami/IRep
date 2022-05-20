import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { ForgotPassComponent } from './page/forgotPass/forgotPass.component';
import { LoginComponent } from './page/Login/login.component';
import { RegisterComponent } from './page/register/register.component';

const routes: Routes = [
  { path: '',
    pathMatch: 'full',
    redirectTo: 'login',
  },
  { path: 'login', component: LoginComponent },
  { path: 'register', component: RegisterComponent },
  { path: 'forgot-pass', component: ForgotPassComponent }
];

@NgModule({
  imports: [
    RouterModule.forRoot(routes, {
      useHash: false,
    }),
  ],
  exports: [
    RouterModule,
  ],
})
export class AppRoutingModule { }
