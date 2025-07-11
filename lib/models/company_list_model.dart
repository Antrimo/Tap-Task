class CompanyListModel {
  final String logo;
  final String isin;
  final String rating;
  final String companyName;
  final List<String> tags;

  CompanyListModel({
    required this.logo,
    required this.isin,
    required this.rating,
    required this.companyName,
    required this.tags,
  });

  factory CompanyListModel.fromJson(Map<String, dynamic> json) {
    return CompanyListModel(
      logo: json['logo'] ?? '',
      isin: json['isin'] ?? '',
      rating: json['rating'] ?? '',
      companyName: json['company_name'] ?? '',
      tags: List<String>.from(json['tags'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'logo': logo,
      'isin': isin,
      'rating': rating,
      'company_name': companyName,
      'tags': tags,
    };
  }
}
