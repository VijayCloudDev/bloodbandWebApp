/**
 * Strong-typed interface matching the backend OrganizationModel data structure
 */
export interface OrganizationModel {
  name: string;
  description?: string;
  
  // Geographic Alignment Parameters
  countryId: number;
  stateId: number;
  districtId: number;
  place: string;
  pincode: string;

  // Regulatory Coordinates
  registrationNumber: string;
  registrationType: string;
  registrationDate: Date | string;
  licenseNumber: string;
  licenseIssuedBy: string;

  // Access Credentials & Contact Channels
  phoneNumber: string;
  email: string;
  password?: string;
}