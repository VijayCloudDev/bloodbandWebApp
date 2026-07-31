import { Injectable, inject } from '@angular/core';
import { Router } from '@angular/router';
import { jwtDecode } from 'jwt-decode';

@Injectable({ providedIn: 'root' })
export class AuthService {
  private readonly router = inject(Router);
  private readonly tokenKey = 'token';
  private readonly refreshTokenKey = 'refreshToken';

  getToken(): string | null {
    return localStorage.getItem(this.tokenKey);
  }

  getRefreshToken(): string | null {
    return localStorage.getItem(this.refreshTokenKey);
  }

  isLoggedIn(): boolean {
    return !!this.getToken();
  }

  setSession(accessToken: string, refreshToken?: string): void {
    localStorage.setItem(this.tokenKey, accessToken);
    if (refreshToken) {
      localStorage.setItem(this.refreshTokenKey, refreshToken);
    }
  }

  clearSession(): void {
    localStorage.removeItem(this.tokenKey);
    localStorage.removeItem(this.refreshTokenKey);
  }

  /** Sign out: clear tokens and return to login. */
  logout(): void {
    this.clearSession();
    this.router.navigate(['/login']);
  }

  getUserRole(): string {
    const token = this.getToken();
    if (!token) {
      return '';
    }

    try {
      const decoded: Record<string, unknown> = jwtDecode(token);
      const role =
        (decoded['role'] as string | undefined) ??
        (decoded[
          'http://schemas.microsoft.com/ws/2008/06/identity/claims/role'
        ] as string | undefined);
      return role ?? '';
    } catch {
      return '';
    }
  }

  getDisplayName(): string {
    const token = this.getToken();
    if (!token) {
      return 'Account';
    }

    try {
      const decoded: Record<string, unknown> = jwtDecode(token);
      const name =
        (decoded[
          'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name'
        ] as string | undefined) ??
        (decoded['unique_name'] as string | undefined) ??
        (decoded['name'] as string | undefined);
      return name?.trim() || 'Account';
    } catch {
      return 'Account';
    }
  }
}
