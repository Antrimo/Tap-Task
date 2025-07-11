class CompanyDetailModel {
  final String logo;
  final String companyName;
  final String description;
  final String isin;
  final String status;
  final ProsCons prosAndCons;
  final IssuerDetails issuerDetails;

  CompanyDetailModel({
    required this.logo,
    required this.companyName,
    required this.description,
    required this.isin,
    required this.status,
    required this.prosAndCons,
    required this.issuerDetails,
  });

  factory CompanyDetailModel.fromJson(Map<String, dynamic> json) {
    return CompanyDetailModel(
      logo: json['logo'],
      companyName: json['company_name'],
      description: json['description'],
      isin: json['isin'],
      status: json['status'],
      prosAndCons: ProsCons.fromJson(json['pros_and_cons']),
      issuerDetails: IssuerDetails.fromJson(json['issuer_details']),
    );
  }
}

class ProsCons {
  final List<String> pros;
  final List<String> cons;

  ProsCons({required this.pros, required this.cons});

  factory ProsCons.fromJson(Map<String, dynamic> json) {
    return ProsCons(
      pros: List<String>.from(json['pros']),
      cons: List<String>.from(json['cons']),
    );
  }
}


class IssuerDetails {
  final String issuerName;
  final String typeOfIssuer;
  final String sector;
  final String industry;
  final String issuerNature;
  final String cin;
  final String leadManager;
  final String registrar;
  final String debentureTrustee;

  IssuerDetails({
    required this.issuerName,
    required this.typeOfIssuer,
    required this.sector,
    required this.industry,
    required this.issuerNature,
    required this.cin,
    required this.leadManager,
    required this.registrar,
    required this.debentureTrustee,
  });

  factory IssuerDetails.fromJson(Map<String, dynamic> json) {
    return IssuerDetails(
      issuerName: json['issuer_name'],
      typeOfIssuer: json['type_of_issuer'],
      sector: json['sector'],
      industry: json['industry'],
      issuerNature: json['issuer_nature'],
      cin: json['cin'],
      leadManager: json['lead_manager'],
      registrar: json['registrar'],
      debentureTrustee: json['debenture_trustee'],
    );
  }
}
