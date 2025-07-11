import 'package:flutter/material.dart';
import 'package:tap/models/company_detail_model.dart';

class IssuerDetailsWidget extends StatelessWidget {
  final IssuerDetails issuerDetails;

  const IssuerDetailsWidget({super.key, required this.issuerDetails});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                SizedBox(width: 8),
                Icon(Icons.person_add_alt_1_sharp, color: Colors.grey),
                SizedBox(width: 8),
                Text(
                  'Issuer Details',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: Colors.grey, thickness: 1, height: 24),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IssuerDetailRow(
                  label: "Issuer Name",
                  value: issuerDetails.issuerName,
                ),
                IssuerDetailRow(
                  label: "Type of Issuer",
                  value: issuerDetails.typeOfIssuer,
                ),
                IssuerDetailRow(label: "Sector", value: issuerDetails.sector),
                IssuerDetailRow(
                  label: "Industry",
                  value: issuerDetails.industry,
                ),
                IssuerDetailRow(
                  label: "Issuer Nature",
                  value: issuerDetails.issuerNature,
                ),
                IssuerDetailRow(label: "CIN", value: issuerDetails.cin),
                IssuerDetailRow(
                  label: "Lead Manager",
                  value: issuerDetails.leadManager,
                ),
                IssuerDetailRow(
                  label: "Registrar",
                  value: issuerDetails.registrar,
                ),
                IssuerDetailRow(
                  label: "Debenture Trustee",
                  value: issuerDetails.debentureTrustee,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class IssuerDetailRow extends StatelessWidget {
  final String label;
  final String value;

  const IssuerDetailRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.blue.shade700,
            fontSize: 12,
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: TextStyle(
            color: Colors.grey.shade900,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
