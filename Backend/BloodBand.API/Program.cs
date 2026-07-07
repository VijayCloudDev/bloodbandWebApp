using BloodBand.Business.Services;
using BloodBand.Data;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using System.Reflection;
using System.Security.Claims;
using System.Text;

var builder = WebApplication.CreateBuilder(args);

#region ✅ Controllers
builder.Services.AddControllers();
#endregion

#region ✅ Swagger Configuration
builder.Services.AddEndpointsApiExplorer();

builder.Services.AddSwaggerGen(options =>
{
    options.SwaggerDoc("v1", new OpenApiInfo
    {
        Title = "BloodBand API",
        Version = "v1",
        Description = "Blood Donation Management API"
    });

    // ✅ JWT AUTH SUPPORT
    options.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
    {
        Name = "Authorization",
        Type = SecuritySchemeType.Http,
        Scheme = "bearer",
        BearerFormat = "JWT",
        In = ParameterLocation.Header,
        Description = "Enter JWT like: Bearer {your token}"
    });

    options.AddSecurityRequirement(new OpenApiSecurityRequirement
    {
        {
            new OpenApiSecurityScheme
            {
                Reference = new OpenApiReference
                {
                    Type = ReferenceType.SecurityScheme,
                    Id = "Bearer"
                }
            },
            new string[] {}
        }
    });

    // ✅ XML COMMENTS (for controller documentation)
    var xmlFile = $"{Assembly.GetExecutingAssembly().GetName().Name}.xml";
    var xmlPath = Path.Combine(AppContext.BaseDirectory, xmlFile);

    if (File.Exists(xmlPath))
        options.IncludeXmlComments(xmlPath);
});
#endregion

#region ✅ CORS
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll",
        policy =>
            policy.AllowAnyOrigin()
                  .AllowAnyMethod()
                  .AllowAnyHeader());
});
#endregion

#region ✅ JWT CONFIGURATION
var key = builder.Configuration["Jwt:Key"];
var issuer = builder.Configuration["Jwt:Issuer"];
var audience = builder.Configuration["Jwt:Audience"];

if (string.IsNullOrEmpty(key) || string.IsNullOrEmpty(issuer) || string.IsNullOrEmpty(audience))
    throw new Exception("JWT configuration is missing");

builder.Services.AddAuthentication(options =>
{
    options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
})
.AddJwtBearer(options =>
{
    options.RequireHttpsMetadata = false;
    options.SaveToken = true;

    options.TokenValidationParameters = new TokenValidationParameters
    {
        ValidateIssuer = true,
        ValidateAudience = true,
        ValidateLifetime = true,
        ValidateIssuerSigningKey = true,

        ValidIssuer = issuer,
        ValidAudience = audience,

        RoleClaimType = ClaimTypes.Role,

        IssuerSigningKey = new SymmetricSecurityKey(
            Encoding.UTF8.GetBytes(key)
        ),

        ClockSkew = TimeSpan.Zero
    };
});
#endregion

#region ✅ Dependency Injection
builder.Services.AddSingleton<DapperContext>();

builder.Services.AddScoped<UserService>();
builder.Services.AddScoped<UserRepository>();

builder.Services.AddScoped<OrganizationService>();
builder.Services.AddScoped<OrganizationRepository>();

builder.Services.AddScoped<RequestService>();
builder.Services.AddScoped<RequestRepository>();

builder.Services.AddScoped<DonationService>();
builder.Services.AddScoped<DonationRepository>();

builder.Services.AddScoped<AuthService>();
builder.Services.AddScoped<RefreshTokenRepository>();

builder.Services.AddScoped<SearchService>();
builder.Services.AddScoped<SearchRepository>();

builder.Services.AddScoped<NotificationService>();
builder.Services.AddScoped<NotificationRepository>();

builder.Services.AddScoped<DashboardService>();
builder.Services.AddScoped<DashboardRepository>();

builder.Services.AddScoped<ChatService>();
builder.Services.AddScoped<ChatRepository>();

builder.Services.AddScoped<AdService>();
builder.Services.AddScoped<AdRepository>();

builder.Services.AddAuthorization();
builder.Services.AddHttpContextAccessor();
builder.Services.AddMemoryCache();
#endregion

var app = builder.Build();

#region ✅ Global Exception Handling
app.UseExceptionHandler(errorApp =>
{
    errorApp.Run(async context =>
    {
        context.Response.StatusCode = 500;

        await context.Response.WriteAsJsonAsync(new
        {
            Message = "Internal Server Error"
        });
    });
});
#endregion

#region ✅ Middleware Pipeline

// ✅ Swagger (enabled always)
app.UseSwagger();
app.UseSwaggerUI();

app.UseCors("AllowAll");

app.UseStaticFiles();

app.UseHttpsRedirection();

app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();

#endregion

app.Run();