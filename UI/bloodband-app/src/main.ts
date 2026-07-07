// import { bootstrapApplication } from '@angular/platform-browser';
// import { provideHttpClient } from '@angular/common/http'; 
// import { provideAnimations } from '@angular/platform-browser/animations';
// import { provideRouter } from '@angular/router';

// import { AppComponent } from './app/app.component';
// import { routes } from './app/app.routes';

// bootstrapApplication(AppComponent, {
//   providers: [
//     provideRouter(routes), 
//     provideHttpClient(), 
//     provideAnimations() 
//   ]
// });

import { provideHttpClient, withInterceptors } from '@angular/common/http';
import { authInterceptor } from './app/core/auth.interceptor';
import { bootstrapApplication } from '@angular/platform-browser';
import { AppComponent } from './app/app.component';
import { provideRouter } from '@angular/router';
import { routes } from './app/app.routes';
import { provideAnimations } from '@angular/platform-browser/animations';

bootstrapApplication(AppComponent, {
  providers: [
    provideRouter(routes),
    provideHttpClient(withInterceptors([authInterceptor])),
    provideAnimations()
  ]
});