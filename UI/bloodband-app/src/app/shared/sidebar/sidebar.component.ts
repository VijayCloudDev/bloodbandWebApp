import { Component, OnInit, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { MatListModule } from '@angular/material/list';
import { MatIconModule } from '@angular/material/icon';
import { AuthService } from '../../core/auth.service';

@Component({
  selector: 'app-sidebar',
  standalone: true,
  imports: [CommonModule, RouterModule, MatListModule, MatIconModule],
  templateUrl: './sidebar.component.html',
  styleUrls: ['./sidebar.component.scss'],
})
export class SidebarComponent implements OnInit {
  private readonly auth = inject(AuthService);

  userRole = 'User';

  ngOnInit(): void {
    this.userRole = this.auth.getUserRole() || 'User';
  }

  get isSuperAdmin(): boolean {
    return this.userRole === 'SuperAdmin';
  }

  get isAdmin(): boolean {
    return (
      this.userRole === 'Admin' || this.userRole === 'OrganizationAdmin'
    );
  }

  get isStandardUser(): boolean {
    return (
      !this.isSuperAdmin &&
      !this.isAdmin
    );
  }
}
