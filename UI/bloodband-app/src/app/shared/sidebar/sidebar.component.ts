import { Component, OnInit,inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { MatListModule } from '@angular/material/list';
import { MatIconModule } from '@angular/material/icon';
import { jwtDecode } from 'jwt-decode';

@Component({
  selector: 'app-sidebar',
  standalone: true,
  imports: [CommonModule, RouterModule, MatListModule, MatIconModule],
  templateUrl: './sidebar.component.html',
  styleUrls: ['./sidebar.component.scss']
})
export class SidebarComponent implements OnInit {
  userRole: string = 'User'; // Fallback default state

  ngOnInit(): void {
    this.extractUserRole();
  }

  private extractUserRole(): void {
    const token = localStorage.getItem('token');
    if (token) {
      try {
        const decodedToken: any = jwtDecode(token);
        // Using our safe fallback pattern matching standard backend claim formats
        this.userRole = decodedToken.role ?? decodedToken['http://schemas.microsoft.com/ws/2008/06/identity/claims/role'] ?? 'User';
      } catch (error) {
        console.error('Error decoding authentication token:', error);
        this.userRole = 'User';
      }
    }
  }
}