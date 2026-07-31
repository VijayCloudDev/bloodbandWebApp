import { Component, OnInit, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router } from '@angular/router';
import { MatCardModule } from '@angular/material/card';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { MatDividerModule } from '@angular/material/divider';
import { ApiService } from '../../../core/api.service';
import { AuthService } from '../../../core/auth.service';
import { UserProfile } from '../../../models/user-profile.model';

@Component({
  selector: 'app-user-detail',
  standalone: true,
  imports: [
    CommonModule,
    MatCardModule,
    MatButtonModule,
    MatIconModule,
    MatProgressSpinnerModule,
    MatDividerModule,
  ],
  templateUrl: './user-detail.component.html',
  styleUrl: './user-detail.component.scss',
})
export class UserDetailComponent implements OnInit {
  private readonly api = inject(ApiService);
  private readonly auth = inject(AuthService);
  private readonly router = inject(Router);

  profile: UserProfile | null = null;
  loading = true;
  error = '';
  uploading = false;

  ngOnInit(): void {
    this.loadProfile();
  }

  loadProfile(): void {
    this.loading = true;
    this.error = '';

    this.api.get<UserProfile>('user/profile').subscribe({
      next: (data) => {
        this.profile = data;
        this.loading = false;
      },
      error: (err) => {
        this.loading = false;
        this.error =
          err?.error?.message ||
          err?.error?.Message ||
          'Unable to load profile. Please try again.';
      },
    });
  }

  resolveImageUrl(path: string | null | undefined): string | null {
    if (!path) {
      return null;
    }
    if (path.startsWith('http://') || path.startsWith('https://')) {
      return path;
    }
    return `${this.api.mediaBaseUrl}${path.startsWith('/') ? '' : '/'}${path}`;
  }

  onFileSelected(event: Event): void {
    const input = event.target as HTMLInputElement;
    const file = input.files?.[0];
    if (!file) {
      return;
    }

    this.uploading = true;
    this.error = '';

    const formData = new FormData();
    formData.append('file', file);

    this.api.postFormData<{ imageUrl?: string; ImageUrl?: string }>(
      'user/upload-profile-image',
      formData,
    ).subscribe({
      next: (res) => {
        this.uploading = false;
        const imageUrl = res.imageUrl ?? res.ImageUrl ?? '';
        if (this.profile && imageUrl) {
          this.profile = { ...this.profile, profileImageUrl: imageUrl };
        } else {
          this.loadProfile();
        }
        input.value = '';
      },
      error: (err) => {
        this.uploading = false;
        this.error =
          err?.error?.message ||
          (typeof err?.error === 'string' ? err.error : null) ||
          'Profile image upload failed.';
        input.value = '';
      },
    });
  }

  signOut(): void {
    this.auth.logout();
  }

  goBack(): void {
    const role = this.auth.getUserRole();
    if (role === 'SuperAdmin') {
      this.router.navigate(['/super-admin-dashboard']);
    } else if (role === 'Admin' || role === 'OrganizationAdmin') {
      this.router.navigate(['/admin-dashboard']);
    } else {
      this.router.navigate(['/dashboard']);
    }
  }
}
