/**
 * Data Transfer Object for regular user login (Phone + Password)
 */
export interface UserLoginDto {
  phoneNumber: string;
  password: string;
}

/**
 * Data Transfer Object for administrative logins (Email + Password)
 */
export interface AdminLoginDto {
  email: string;
  password: string;
}

/**
 * Strong-typed structure mapping directly to the backend LoginResponseDto structure
 */
export interface LoginResponseDto {
  accessToken: string;
  refreshToken: string;
}