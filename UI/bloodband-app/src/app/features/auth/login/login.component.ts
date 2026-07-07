import { Component, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import {
  FormBuilder,
  FormGroup,
  Validators,
  ReactiveFormsModule,
} from '@angular/forms';
import { Router } from '@angular/router';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatButtonModule } from '@angular/material/button';
import { MatCardModule } from '@angular/material/card';
import { MatTabsModule } from '@angular/material/tabs';
import { MatIconModule } from '@angular/material/icon';
import { ApiService } from '../../../core/api.service';
import { MatSelectModule } from '@angular/material/select';
import { MatOptionModule } from '@angular/material/core';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatNativeDateModule } from '@angular/material/core';
import { jwtDecode } from 'jwt-decode'; // ✅ Standard import for reading payload schemas
import {
  AdminLoginDto,
  LoginResponseDto,
  UserLoginDto,
} from '../../../models/auth-dto.model';

type AuthViewMode = 'login' | 'signup' | 'forgot' | 'admin-forgot';

@Component({
  selector: 'app-login',
  standalone: true,
  imports: [
    CommonModule,
    ReactiveFormsModule,
    MatFormFieldModule,
    MatInputModule,
    MatButtonModule,
    MatCardModule,
    MatTabsModule,
    MatIconModule,
    MatSelectModule,
    MatOptionModule,
    MatDatepickerModule,
    MatNativeDateModule,
  ],
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss'],
})
export class LoginComponent {
  private fb = inject(FormBuilder);
  private router = inject(Router);
  private apiService = inject(ApiService);

  authMode: AuthViewMode = 'login';

  userForm: FormGroup;
  adminForm: FormGroup;
  signUpForm: FormGroup;
  forgotPasswordForm: FormGroup;
  adminForgotForm: FormGroup;

  loading = false;
  error = '';
  hidePassword = true;

  constructor() {
    this.userForm = this.fb.group({
      phoneNumber: [
        '',
        [Validators.required, Validators.pattern(/^[0-9]{10}$/)],
      ],
      password: ['', [Validators.required, Validators.minLength(6)]],
    });

    this.adminForm = this.fb.group({
      email: ['', [Validators.required, Validators.email]],
      password: ['', [Validators.required]],
    });

    this.signUpForm = this.fb.group(
      {
        fullName: ['', [Validators.required, Validators.minLength(3)]],
        phoneNumber: [
          '',
          [Validators.required, Validators.pattern(/^[0-9]{10}$/)],
        ],
        emailId: ['', [Validators.email]],
        password: ['', [Validators.required, Validators.minLength(6)]],
        confirmPassword: ['', [Validators.required]],
      },
      { validators: this.passwordMatchValidator },
    );

    this.forgotPasswordForm = this.fb.group({
      phoneNumber: [
        '',
        [Validators.required, Validators.pattern(/^[0-9]{10}$/)],
      ],
    });

    this.adminForgotForm = this.fb.group({
      email: ['', [Validators.required, Validators.email]],
    });
  }

  private passwordMatchValidator(g: FormGroup) {
    return g.get('password')?.value === g.get('confirmPassword')?.value
      ? null
      : { mismatch: true };
  }

  switchMode(mode: AuthViewMode): void {
    this.authMode = mode;
    this.error = '';
    this.loading = false;
  }

  onUserLogin(): void {
    if (this.userForm.invalid) return;
    const payload: UserLoginDto = this.userForm.value;
    this.executeAuthRequest('user/login', payload);
    // this.executeAuthRequest('user/login', this.userForm.value); // ✅ Corrected route path
  }

  // onAdminLogin(): void {
  //   if (this.adminForm.invalid) return;
  //   this.executeAuthRequest('user/admin-login', this.adminForm.value); // ✅ Corrected route path
  // }
  onAdminLogin(): void {
    if (this.adminForm.invalid) return;

    // Explicitly casting the form value to our AdminLoginDto structure
    const payload: AdminLoginDto = this.adminForm.value;
    this.executeAuthRequest('user/admin-login', payload);
  }

  onSignUpSubmit(): void {
    if (this.signUpForm.invalid) {
      this.error = this.signUpForm.hasError('mismatch')
        ? 'Passwords do not match.'
        : 'Please check registration inputs.';
      return;
    }
    this.executeAuthRequest('user/register', this.signUpForm.value); // ✅ Corrected route path
  }

  onForgotPasswordSubmit(): void {
    if (this.forgotPasswordForm.invalid) return;
    this.executeRecoveryRequest(
      'user/forgot-password',
      this.forgotPasswordForm.value,
      'OTP sent to mobile.',
    );
  }

  onAdminForgotSubmit(): void {
    if (this.adminForgotForm.invalid) return;
    this.executeRecoveryRequest(
      'user/admin-forgot-password',
      this.adminForgotForm.value,
      'Reset instructions transmitted to admin email address.',
    );
  }

  private executeAuthRequest(
    endpoint: string,
    payload: UserLoginDto | AdminLoginDto,
  ): void {
    this.loading = true;
    this.error = '';
    this.apiService.post<LoginResponseDto>(endpoint, payload).subscribe({
      next: (response: LoginResponseDto) => {
        this.loading = false;

        // Match with LoginResponseDto properties ('accessToken')[cite: 6]
        if (response && response.accessToken) {
          localStorage.setItem('token', response.accessToken); // Keep key as 'token' for interceptors[cite: 12]

          try {
            const decodedToken: any = jwtDecode(response.accessToken);

            // Clean extraction filtering standard strings or structured URI fallbacks
            const userRole =
              decodedToken.role ??
              decodedToken[
                'http://schemas.microsoft.com/ws/2008/06/identity/claims/role'
              ];
            console.log('Decoded JWT Role:', userRole); // Debugging output for role verification
            // 🔀 Route to appropriate dashboard based on user role
            // 🔀 Route to appropriate dashboard based on user role[cite: 18]
            if (userRole === 'SuperAdmin') {
              console.log(
                'SuperAdmin detected, navigating to super-admin-dashboard',
              );
              this.router.navigate(['/super-admin-dashboard']); // Matches path declared in routing config[cite: 18]
            } else if (userRole === 'Admin') {
              console.log('Admin detected, navigating to admin-dashboard');
              this.router.navigate(['/admin-dashboard']);
            } else {
              console.log(
                'Standard user detected, navigating to user-dashboard',
              );
              this.router.navigate(['/dashboard']);
            }
          } catch (decodeError) {
            // Fallback route if the token format is unexpected
            this.router.navigate(['/dashboard']);
          }
        }
      },
      error: (err) => {
        this.loading = false;
        this.error = err?.error?.message || 'Authentication processing error.';
      },
    });
  }

  private executeRecoveryRequest(
    endpoint: string,
    payload: any,
    successMessage: string,
  ): void {
    this.loading = true;
    this.error = '';
    this.apiService.post(endpoint, payload).subscribe({
      next: () => {
        this.loading = false;
        alert(successMessage);
        this.switchMode('login');
      },
      error: (err) => {
        this.loading = false;
        this.error = err?.error?.message || 'Action failed.';
      },
    });
  }

  navigateToOrgRegistration(): void {
    this.router.navigate(['/register-organization']);
  }
}
