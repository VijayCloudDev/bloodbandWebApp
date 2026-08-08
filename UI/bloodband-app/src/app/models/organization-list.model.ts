export interface OrganizationListItem {
  organizationId: number;
  name: string;
  description?: string;
  place?: string;
  pincode?: string;
  phoneNumber?: string;
  email?: string;
  registrationNumber?: string;
  registrationType?: string;
  registrationDate?: string;
  licenseNumber?: string;
  licenseIssuedBy?: string;
  isVerified: boolean;
  createdAt?: string;
  statusId: number;
  statusName?: string;
  countryName?: string;
  stateName?: string;
  districtName?: string;
}

/** Organization StatusMaster ids (StatusType = Organization). */
export const OrgStatus = {
  Pending: 1,
  Approved: 2,
  Rejected: 3
} as const;
