import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

@Injectable({ providedIn: 'root' })
export class ApiService {

  baseUrl = 'https://localhost:7255/api';

  /** API host without `/api` — used for static uploads (profile images). */
  get mediaBaseUrl(): string {
    return this.baseUrl.replace(/\/api\/?$/, '');
  }

  constructor(private http: HttpClient) {}

  get<T>(url: string): Observable<T> {
    return this.http.get<T>(`${this.baseUrl}/${url}`);
  }

  // ✅ Added generic type argument <T> to enforce model safety on payloads and return maps
  post<T>(url: string, body: any): Observable<T> {
    return this.http.post<T>(`${this.baseUrl}/${url}`, body);
  }

  /** Multipart upload (e.g. profile image). Do not set Content-Type manually. */
  postFormData<T>(url: string, formData: FormData): Observable<T> {
    return this.http.post<T>(`${this.baseUrl}/${url}`, formData);
  }

  put<T>(url: string, body: any): Observable<T> {
    return this.http.put<T>(`${this.baseUrl}/${url}`, body);
  }
  
  getDashboard(): Observable<any> {
    return this.http.get<any>(`${this.baseUrl}/dashboard`);
  }
}