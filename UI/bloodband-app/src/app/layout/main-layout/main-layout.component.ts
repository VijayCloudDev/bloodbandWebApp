import { Component, AfterViewInit, ViewChild, inject, DestroyRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterOutlet, Router, NavigationEnd } from '@angular/router';
import { MatSidenavModule, MatSidenav } from '@angular/material/sidenav';
import { BreakpointObserver, Breakpoints } from '@angular/cdk/layout';
import { takeUntilDestroyed } from '@angular/core/rxjs-interop';
import { filter, map, shareReplay, withLatestFrom } from 'rxjs/operators'; // Added withLatestFrom
import { Observable } from 'rxjs';
import { HeaderComponent } from '../../shared/header/header.component';
import { SidebarComponent } from '../../shared/sidebar/sidebar.component';
import { FooterComponent } from '../../shared/footer/footer.component';

@Component({
  selector: 'app-main-layout',
  standalone: true,
  imports: [
    CommonModule, 
    RouterOutlet, 
    MatSidenavModule, 
    HeaderComponent, 
    SidebarComponent, 
    FooterComponent
  ],
  templateUrl: './main-layout.component.html',
  styleUrls: ['./main-layout.component.scss']
})
export class MainLayoutComponent implements AfterViewInit {
  @ViewChild('sidenav') sidenav!: MatSidenav;
  
  private router = inject(Router);
  private breakpointObserver = inject(BreakpointObserver);
  private destroyRef = inject(DestroyRef);

  isHandset$: Observable<boolean> = this.breakpointObserver
    .observe([Breakpoints.Handset, Breakpoints.TabletPortrait])
    .pipe(
      map(result => result.matches),
      shareReplay()
    );

  ngAfterViewInit() {
    // 1. Structural Window Resize Management
    this.isHandset$
      .pipe(takeUntilDestroyed(this.destroyRef))
      .subscribe(isMobile => {
        if (this.sidenav) {
          if (isMobile) {
            this.sidenav.close();
          } else {
            this.sidenav.open();
          }
        }
      });

    // 2. Automated Mobile Navigation Logic WITH EXPLICIT WEB VIEW PROTECTION
    this.router.events
      .pipe(
        filter(event => event instanceof NavigationEnd),
        withLatestFrom(this.isHandset$), // Cleanly grabs the exact mobile state at this specific moment
        takeUntilDestroyed(this.destroyRef)
      )
      .subscribe(([event, isMobile]) => {
        // STRICT BLOCK: The sidebar is allowed to close ONLY when running inside mobile handset mode
        if (isMobile && this.sidenav) {
          this.sidenav.close(); 
        }
      });
  }
}