import { Injectable } from '@angular/core';

import { ToastrService } from 'ngx-toastr';

@Injectable({
  providedIn: 'root'
})
export class NotificationService {

  constructor(private toastr: ToastrService) { }

  public showSuccess(message: string, title: string): void{
      this.toastr.success(message, title);
  }

  public showError(message: string, title: string): void{
      this.toastr.error(message, title);
  }

  public showInfo(message: string, title: string): void{
      this.toastr.info(message, title);
  }

  public showWarning(message: string, title: string): void{
      this.toastr.warning(message, title);
  }

}
