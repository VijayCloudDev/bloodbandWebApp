import { Component, OnInit, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormBuilder, FormGroup, Validators, ReactiveFormsModule, FormControl, FormGroupDirective, NgForm } from '@angular/forms';
import { Router } from '@angular/router';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatButtonModule } from '@angular/material/button';
import { MatCardModule } from '@angular/material/card';
import { MatIconModule } from '@angular/material/icon';
import { MatSelectModule } from '@angular/material/select';
import { MatOptionModule } from '@angular/material/core';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatNativeDateModule, ErrorStateMatcher } from '@angular/material/core';
import { ApiService } from '../../../core/api.service';
import { CountryOption } from '../../../models/country.model';
import { OrganizationModel } from '../../../models/organization.model';
import { RegistrationTypeOption } from '../../../models/registration-type.model';
import { MatStepperModule, MatStepper } from '@angular/material/stepper';

/**
 * CUSTOM ERROR STATE MATCHER
 * Overrides default behavior to force evaluation rendering the second an invalid control is flagged as touched
 */
export class InstantErrorStateMatcher implements ErrorStateMatcher {
  isErrorState(control: FormControl | null, form: FormGroupDirective | NgForm | null): boolean {
    return !!(control && control.invalid && control.touched);
  }
}

@Component({
  selector: 'app-organization-registration',
  standalone: true,
  imports: [
    CommonModule,
    ReactiveFormsModule,
    MatFormFieldModule,
    MatInputModule,
    MatButtonModule,
    MatCardModule,
    MatIconModule,
    MatSelectModule,
    MatOptionModule,
    MatDatepickerModule,
    MatNativeDateModule,
    MatStepperModule
  ],
  templateUrl: './org-signup.component.html',
  styleUrls: ['./org-signup.component.scss']
})
export class OrganizationRegistrationComponent implements OnInit {
  private fb = inject(FormBuilder);
  private router = inject(Router);
  private apiService = inject(ApiService);

  adminSignUpForm: FormGroup;
  countries: CountryOption[] = [];
  registrationTypes: RegistrationTypeOption[] = [];
  loading = false;
  error = '';

  // Expose instance variable reference to the HTML Template context
  matcher = new InstantErrorStateMatcher();

  // Strongly typed sub-group wrappers preventing strict compilation null injection faults
  get identityGroup(): FormGroup {
    return this.adminSignUpForm.get('identity') as FormGroup;
  }

  get complianceGroup(): FormGroup {
    return this.adminSignUpForm.get('compliance') as FormGroup;
  }

  get locationGroup(): FormGroup {
    return this.adminSignUpForm.get('location') as FormGroup;
  }

  get securityGroup(): FormGroup {
    return this.adminSignUpForm.get('security') as FormGroup;
  }

  constructor() {
    this.adminSignUpForm = this.fb.group({
      identity: this.fb.group({
        name: ['', [Validators.required, Validators.minLength(3)]],
        description: ['']
      }),
      compliance: this.fb.group({
        registrationNumber: ['', [Validators.required]],
        registrationType: [null, [Validators.required]],
        registrationDate: [null, [Validators.required]],
        licenseNumber: ['', [Validators.required]],
        licenseIssuedBy: ['', [Validators.required]]
      }),
      location: this.fb.group({
        countryId: [null, [Validators.required]],
        stateId: [null, [Validators.required]],
        districtId: [null, [Validators.required]],
        place: ['', [Validators.required]],
        pincode: ['', [Validators.required, Validators.pattern(/^[0-9]{6}$/)]]
      }),
      security: this.fb.group({
        phoneNumber: ['', [Validators.required, Validators.pattern(/^[0-9]{10}$/)]],
        email: ['', [Validators.required, Validators.email]],
        password: ['', [Validators.required, Validators.minLength(6)]],
        confirmPassword: ['', [Validators.required]]
      })
    }, { validators: this.passwordMatchValidator });
  }

  ngOnInit(): void {
    this.loadCountries();
    this.loadRegistrationTypes();
  }

  private loadCountries(): void {
    this.apiService.get<CountryOption[]>('common/countries').subscribe({
      next: (countries) => {
        this.countries = countries;
      },
      error: (err) => {
        console.error('Failed to load countries:', err);
        this.error = 'Unable to load countries.';
      }
    });
  }

  private loadRegistrationTypes(): void {
    this.apiService.get<RegistrationTypeOption[]>('common/registration-types').subscribe({
      next: (registrationTypes) => {
        this.registrationTypes = registrationTypes;
      },
      error: (err) => {
        console.error('Failed to load registration types:', err);
        this.error = 'Unable to load registration types.';
      }
    });
  }

  private passwordMatchValidator(g: FormGroup) {
    const securityGroup = g.get('security');
    if (!securityGroup) return null;

    const password = securityGroup.get('password')?.value;
    const confirmPassword = securityGroup.get('confirmPassword')?.value;

    return password === confirmPassword ? null : { mismatch: true };
  }

  /**
   * Evaluates sub-group structure state constraints. Hot-reloads validation hooks inside pristine frames.
   */
  validateStep(stepGroup: FormGroup, stepper: MatStepper): void {
    if (stepGroup.valid) {
      stepper.next();
    } else {
      Object.keys(stepGroup.controls).forEach(field => {
        const control = stepGroup.get(field);
        control?.markAsTouched({ onlySelf: true });
        control?.updateValueAndValidity({ emitEvent: true });
      });
    }
  }

  onAdminSignUpSubmit(): void {
    if (this.adminSignUpForm.invalid) {
      Object.keys(this.securityGroup.controls).forEach(field => {
        const control = this.securityGroup.get(field);
        control?.markAsTouched({ onlySelf: true });
        control?.updateValueAndValidity({ emitEvent: true });
      });

      this.error = this.adminSignUpForm.hasError('mismatch')
        ? 'Passwords do not match.'
        : 'Please completely fill organization credentials.';
      return;
    }

    this.loading = true;
    this.error = '';

    const formValue = this.adminSignUpForm.value;
    const payload: OrganizationModel = {
      ...formValue.identity,
      ...formValue.compliance,
      ...formValue.location,
      ...formValue.security
    };

    this.apiService.post<any>('org', payload).subscribe({
      next: (response: any) => {
        console.log('Organization registration response:', response);
        this.loading = false;
        alert('Your medical facility node application was successfully filed and is pending review.');
        this.router.navigate(['/login']);
      },
      error: (err) => {
        this.loading = false;
        this.error = err?.error?.message || 'Facility submission processing failure.';
        console.error('Organization registration error:', err);
      }
    });
  }

  navigateToLogin(): void {
    this.router.navigate(['/login']);
  }
}