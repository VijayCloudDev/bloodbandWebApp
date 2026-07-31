# AGENTS.md

## Cursor Cloud specific instructions

BloodBand is a full-stack blood donation management app: Angular 18 frontend (`UI/bloodband-app`), ASP.NET Core 8 API (`Backend/BloodBand.API`), and SQL Server (`DB/` scripts).

### Services (minimum E2E stack)

| Service | Port | How to start |
|---------|------|--------------|
| SQL Server (Docker) | 1433 | See **Database** below |
| BloodBand API (HTTPS) | 7255 | `cd Backend/BloodBand.API && ASPNETCORE_ENVIRONMENT=Development dotnet run --launch-profile https` |
| Angular dev server | 4200 | `cd UI/bloodband-app && npm start -- --host 0.0.0.0 --disable-host-check` |

The frontend hardcodes `https://localhost:7255/api` in `api.service.ts`. Always run the API with the **https** launch profile.

### Database

SQL Server runs in Docker (not started by the VM update script). First-time setup:

```bash
# Start Docker daemon if needed (Cloud VM)
sudo dockerd > /tmp/dockerd.log 2>&1 &

sudo docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=BloodBand_Dev123!" \
  -p 1433:1433 --name bloodband-sql -d mcr.microsoft.com/mssql/server:2022-latest

# Wait for SQL Server, then create DB and apply schema (skip Windows-specific CREATE DATABASE in script)
sudo docker exec bloodband-sql /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "BloodBand_Dev123!" -C \
  -Q "IF DB_ID('BloodBandDB_Main') IS NULL CREATE DATABASE BloodBandDB_Main"

tail -n +83 DB/Blooddbscript_V08.sql | sudo docker exec -i bloodband-sql \
  /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "BloodBand_Dev123!" -C -b
```

Connection string for local dev is in `Backend/BloodBand.API/appsettings.Development.json` (SA auth to `localhost,1433`).

**Gotcha:** When using `sqlcmd` from the host shell, quote the password with double quotes (`"BloodBand_Dev123!"`) — single-quoted passwords with `!` fail in bash. Always pass `-C` to trust the self-signed cert inside the container.

### HTTPS dev certificate

Run once per VM user: `dotnet dev-certs https --trust`. Browsers may still need you to visit `https://localhost:7255` once and accept the cert before the Angular app can call the API.

### Lint / test / build

| Component | Command | Notes |
|-----------|---------|-------|
| API build | `cd Backend/BloodBand.API && dotnet build` | No separate linter configured |
| Angular dev compile | `npm start` (via `ng serve`) | Dev server hot-reloads |
| Angular production build | `cd UI/bloodband-app && npm run build` | May fail on SCSS bundle **budget** limits (pre-existing) |
| Angular unit tests | `cd UI/bloodband-app && npx ng test --watch=false --browsers=ChromeHeadless` | `org-signup.component.spec.ts` imports a renamed component (`OrgSignupComponent` vs `OrganizationRegistrationComponent`) and currently blocks Karma |

### Seeded dev credentials

The V08 DB script seeds a SuperAdmin (`superadmin@bloodband.com`, phone `0000000000`). For donor flows, register via `POST /api/user/register` or the UI; example test user: phone `9876543210`, password `TestPass123!`.

### Swagger

API docs: `https://localhost:7255/swagger`
