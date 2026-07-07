import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MatCardModule } from '@angular/material/card';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatProgressBarModule } from '@angular/material/progress-bar';
import { MatTableModule } from '@angular/material/table';
import { ApiService } from '../../../core/api.service';


@Component({
  selector: 'app-admin-dashboard',
  standalone: true,
  imports: [ CommonModule,
    MatCardModule,
    MatButtonModule,
    MatIconModule,
    MatProgressBarModule,
    MatTableModule],
  templateUrl: './admin-dashboard.component.html',
  styleUrl: './admin-dashboard.component.scss'
})
export class AdminDashboardComponent implements OnInit {

  dashboardData: any;

  displayedColumns: string[] = ['name', 'date', 'drawDate'];

  dataSource = [
    { initials: 'RA', name: 'Ranton', date: 'Jan 18, 2022', drawDate: 'Jan 14, 2023' },
    { initials: 'RE', name: 'Barvin', date: 'Jan 10, 2023', drawDate: 'Jan 15, 2023' },
    { initials: 'NM', name: 'Nommo', date: 'Jan 12, 2023', drawDate: 'Jan 16, 2023' }
  ];

  constructor(private api: ApiService) {}

  ngOnInit(): void {
    this.loadDashboard();
  }

  loadDashboard() {
    this.api.getDashboard().subscribe({
      next: (res) => {
        console.log(res);
        this.dashboardData = res;
      },
      error: (err) => console.error(err)
    });
  }
}