import { Component, OnInit, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { MatCardModule } from '@angular/material/card';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatTableModule } from '@angular/material/table';
import { MatTooltipModule } from '@angular/material/tooltip';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { MatSnackBar, MatSnackBarModule } from '@angular/material/snack-bar';
import { MatButtonToggleModule } from '@angular/material/button-toggle';
import { ApiService } from '../../../core/api.service';
import { OrganizationListItem, OrgStatus } from '../../../models/organization-list.model';

type StatusFilter = 'pending' | 'approved' | 'rejected' | 'all';

@Component({
  selector: 'app-organization-list',
  standalone: true,
  imports: [
    CommonModule,
    RouterModule,
    MatCardModule,
    MatButtonModule,
    MatIconModule,
    MatTableModule,
    MatTooltipModule,
    MatProgressSpinnerModule,
    MatSnackBarModule,
    MatButtonToggleModule
  ],
  templateUrl: './organization-list.component.html',
  styleUrl: './organization-list.component.scss'
})
export class OrganizationListComponent implements OnInit {
  private api = inject(ApiService);
  private snack = inject(MatSnackBar);

  readonly OrgStatus = OrgStatus;

  loading = false;
  actionLoadingId: number | null = null;
  filter: StatusFilter = 'pending';
  organizations: OrganizationListItem[] = [];

  displayedColumns: string[] = [
    'name',
    'registration',
    'location',
    'contact',
    'submitted',
    'status',
    'actions'
  ];

  ngOnInit(): void {
    this.loadOrganizations();
  }

  get pendingCount(): number {
    return this.countByStatus(OrgStatus.Pending);
  }

  get approvedCount(): number {
    return this.countByStatus(OrgStatus.Approved);
  }

  get rejectedCount(): number {
    return this.countByStatus(OrgStatus.Rejected);
  }

  private countByStatus(statusId: number): number {
    return this.organizations.filter((o) => o.statusId === statusId).length;
  }

  get filteredOrganizations(): OrganizationListItem[] {
    switch (this.filter) {
      case 'pending':
        return this.organizations.filter((o) => o.statusId === OrgStatus.Pending);
      case 'approved':
        return this.organizations.filter((o) => o.statusId === OrgStatus.Approved);
      case 'rejected':
        return this.organizations.filter((o) => o.statusId === OrgStatus.Rejected);
      default:
        return this.organizations;
    }
  }

  setFilter(value: StatusFilter): void {
    this.filter = value;
  }

  loadOrganizations(): void {
    this.loading = true;
    this.api.get<OrganizationListItem[]>('org/list').subscribe({
      next: (res) => {
        this.organizations = res || [];
        this.loading = false;
      },
      error: (err) => {
        this.loading = false;
        this.organizations = [];
        const msg =
          err?.error?.message ||
          err?.error?.title ||
          'Unable to load organization submissions.';
        this.snack.open(msg, 'Close', { duration: 5000 });
      }
    });
  }

  approve(org: OrganizationListItem): void {
    this.updateStatus(org, OrgStatus.Approved, 'approved');
  }

  reject(org: OrganizationListItem): void {
    this.updateStatus(org, OrgStatus.Rejected, 'rejected');
  }

  private updateStatus(
    org: OrganizationListItem,
    statusId: number,
    label: string
  ): void {
    this.actionLoadingId = org.organizationId;
    this.api
      .put(`org/status?orgId=${org.organizationId}&statusId=${statusId}`, {})
      .subscribe({
        next: () => {
          this.actionLoadingId = null;
          org.statusId = statusId;
          org.statusName = label === 'approved' ? 'Approved' : 'Rejected';
          org.isVerified = statusId === OrgStatus.Approved;
          this.snack.open(`${org.name} was ${label}.`, 'OK', { duration: 3500 });
        },
        error: (err) => {
          this.actionLoadingId = null;
          const msg =
            err?.error?.message ||
            err?.error?.title ||
            `Failed to update ${org.name}.`;
          this.snack.open(msg, 'Close', { duration: 5000 });
        }
      });
  }

  statusChipClass(statusId: number): string {
    switch (statusId) {
      case OrgStatus.Approved:
        return 'active';
      case OrgStatus.Rejected:
        return 'suspended';
      default:
        return 'pending';
    }
  }

  statusLabel(org: OrganizationListItem): string {
    return org.statusName || 'Pending';
  }
}
