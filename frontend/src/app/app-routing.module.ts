import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AdvertsPageComponent } from './page/adverts/adverts.component';
import { AnnouncePageComponent } from './page/announce/announce.component';
import { ConfirmRegisterComponent } from './page/confirm-register/confirm-register.component';
import { DescriptionPageComponent } from './page/description/description.component';
import { ForgotPassComponent } from './page/forgotPass/forgotPass.component';
import { HomeComponent } from './page/home.component';
import { LoginComponent } from './page/login/login.component';
import { RegisterComponent } from './page/register/register.component';

const routes: Routes = [
  { path: '', pathMatch: 'full', redirectTo: 'login',},
  { path: 'login', component: LoginComponent },
  { path: 'register', component: RegisterComponent },
  { path: 'forgot-pass', component: ForgotPassComponent },
  { path: 'confirm', component: ConfirmRegisterComponent },
  { path: 'Irep', component: HomeComponent,
    children: [
      { path: 'dashboard', component: AdvertsPageComponent },
      { path: 'announce', component: AnnouncePageComponent },
      { path: 'description/:advert', component: DescriptionPageComponent },
    ]
  },
  { path: '**', redirectTo: 'login',},
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
