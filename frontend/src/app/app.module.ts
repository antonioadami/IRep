import { MatMenuModule } from '@angular/material/menu';
import { ForgotPassComponent } from './page/forgotPass/forgotPass.component';
import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { ToastrModule } from 'ngx-toastr';

import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatCheckboxModule } from '@angular/material/checkbox'

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { LoginComponent } from './page/login/login.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { RegisterComponent } from './page/register/register.component';
import { AdvertsPageComponent } from './page/adverts/adverts.component';
import { RepHeaderComponent } from './component/Header/header.component';
import { MatIconModule } from '@angular/material/icon';
import { HomeComponent } from './page/home.component';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';
import { RepSidenavComponent } from './component/Sidenav/sidenav.component';
import { MatSidenavModule } from '@angular/material/sidenav';
import { RepCardComponent } from './component/Card/card.component';
import { AnnouncePageComponent } from './page/announce/announce.component';
import { DescriptionPageComponent } from './page/description/description.component';
import { HttpClientModule, HTTP_INTERCEPTORS } from '@angular/common/http';
import { requestInterceptor } from './interceptors/request.interceptor';
import { ReactiveFormsModule } from '@angular/forms';
import { ConfirmRegisterComponent } from './page/confirm-register/confirm-register.component';

@NgModule({
  declarations: [
    // Pages
    AppComponent,
    HomeComponent,
    LoginComponent,
    RegisterComponent,
    ForgotPassComponent,
    AdvertsPageComponent,
    AnnouncePageComponent,
    DescriptionPageComponent,

    // Components
    RepHeaderComponent,
    RepSidenavComponent,
    RepCardComponent,
    ConfirmRegisterComponent,
  ],
  imports: [
    AppRoutingModule,
    BrowserModule,
    CommonModule,
    FontAwesomeModule,

    HttpClientModule,

    BrowserAnimationsModule,

    ReactiveFormsModule,
    MatFormFieldModule,
    MatInputModule,
    MatIconModule,
    MatMenuModule,
    MatSidenavModule,
    MatCheckboxModule,

    // Toastr
    ToastrModule.forRoot(),
  ],
  bootstrap: [AppComponent],
  providers: [
    {
      provide: HTTP_INTERCEPTORS,
      useClass: requestInterceptor,
      multi: true
    }
  ]
})
export class AppModule { }
