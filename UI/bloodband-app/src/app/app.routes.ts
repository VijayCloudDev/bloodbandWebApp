import { Routes } from '@angular/router';
import { authGuard } from './core/auth.guard'; //[cite: 17]

export const routes: Routes = [
  {
    path: 'login',
    loadComponent: () => import('./features/auth/login/login.component').then(m => m.LoginComponent) //[cite: 17]
  },
  { 
    path: 'register-organization', 
    loadComponent: () => import('./features/auth/org-signup/org-signup.component')
      .then(m => m.OrganizationRegistrationComponent) //[cite: 17]
  },
  {
    path: '',
    canActivate: [authGuard], //[cite: 17]
    loadComponent: () => import('./layout/main-layout/main-layout.component').then(m => m.MainLayoutComponent), //[cite: 17]
    children: [
      {
        path: '',
        redirectTo: 'dashboard', //[cite: 17]
        pathMatch: 'full' //[cite: 17]
      },
      {
        path: 'dashboard',
        loadComponent: () => import('./features/dashboard/user-dashboard/user-dashboard.component')
          .then(m => m.UserDashboardComponent) // Standard App Users
      },
      {
        path: 'admin-dashboard',
        loadComponent: () => import('./features/dashboard/admin-dashboard/admin-dashboard.component')
          .then(m => m.AdminDashboardComponent) // Internal Administrators
      },
      {
        path: 'super-admin-dashboard',
        loadComponent: () => import('./features/dashboard/superadmin-dashboard/superadmin-dashboard.component')
          .then(m => m.SuperadminDashboardComponent) // System SuperAdmins
      }
    ]
  },
  {
    path: '**',
    redirectTo: 'dashboard' //[cite: 17]
  }
];