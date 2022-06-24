import { MatMenuModule } from '@angular/material/menu';
import { ForgotPassComponent } from './page/forgotPass/forgotPass.component';
import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { MatFormFieldModule} from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { LoginComponent } from './page/Login/login.component';
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
import { FavoritesPageComponent } from './page/favorites/favorites.component';
import { AnnouncePageComponent } from './page/announce/announce.component';
import { DescriptionPageComponent } from './page/description/description.component';

@NgModule({
  declarations: [
    // Pages
    AppComponent,
    HomeComponent,
    LoginComponent,
    RegisterComponent,
    ForgotPassComponent,
    AdvertsPageComponent,
    FavoritesPageComponent,
    AnnouncePageComponent,
    DescriptionPageComponent,

    // Components
    RepHeaderComponent,
    RepSidenavComponent,
    RepCardComponent,
  ],
  imports: [
    AppRoutingModule,
    BrowserModule,
    CommonModule,
    FontAwesomeModule,

    BrowserAnimationsModule,

    MatFormFieldModule,
    MatInputModule,
    MatIconModule,
    MatMenuModule,
    MatSidenavModule,
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
