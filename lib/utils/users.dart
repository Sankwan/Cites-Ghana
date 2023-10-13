import 'dart:convert';

List<Cites> citesFromMap(String str) => List<Cites>.from(json.decode(str).map((x) => Cites.fromMap(x)));

String citesToMap(List<Cites> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Cites {
  Cites({
    required this.cites_id,
    required this.application_type,
    required this.exporter_name,
    required this.exporter_address,
    required this.importer_name,
    required this.importer_address,
    required this.export_country,
    required this.originating_country,
    required this.CountryCode,
    required this.export_type_id,
    required this.export_purpose_id,
    required this.permit_no,
    required this.voucher,
    required this.tbl_users_id,
    required this.review,
    required this.verify,
    required this.approve,
    required this.paid,
    required this.receipt,
    required this.paid_amount,
  });

  String cites_id;
  String application_type;
  String exporter_name;
  String exporter_address;
  String importer_name;
  String importer_address;
  String export_country;
  String originating_country;
  String CountryCode;
  String export_type_id;
  String export_purpose_id;
  String permit_no;
  String voucher;
  String tbl_users_id;
  String review;
  String verify;
  String approve;
  String paid;
  String receipt;
  String paid_amount;


  factory Cites.fromMap(Map<String, dynamic> json) => Cites(
    cites_id: json["cites_id"] ?? '',
    application_type: json["application_type"] ?? '',
    exporter_name: json["exporter_name"] ?? '',
    exporter_address: json["exporter_address"] ?? '',
    importer_name: json["importer_name"] ?? '',
    importer_address: json["importer_address"] ?? '',
    export_country: json["export_country"] ?? '',
    originating_country: json["originating_country"] ?? '',
    CountryCode: json["CountryCode"] ?? '',
    export_type_id: json["export_type_id"] ?? '',
    export_purpose_id: json["export_purpose_id"] ?? '',
    permit_no: json["permit_no"] ?? '',
    voucher: json["voucher"] ?? '',
    tbl_users_id: json["tbl_users_id"] ?? '',
    review: json["review"] ?? '',
    verify: json["verify"] ?? '',
    approve: json["approve"] ?? '',
    paid: json["paid"] ?? '',
    receipt: json["receipt"] ?? '',
    paid_amount: json["paid_amount"] ?? '',
  );

  Map<String, dynamic> toMap() => {
    "cites_id": cites_id,
    "application_type": application_type,
    "exporter_name": exporter_name,
    "exporter_address": exporter_address,
    "importer_name": importer_name,
    "importer_address": importer_address,
    "export_country": export_country,
    "originating_country": originating_country,
    "CountryCode": CountryCode,
    "export_type_id": export_type_id,
    "export_purpose_id": export_purpose_id,
    "permit_no": permit_no,
    "voucher": voucher,
    "tbl_users_id": tbl_users_id,
    "review": review,
    "verify": verify,
    "approve": approve,
    "paid": paid,
    "receipt": receipt,
    "paid_amount": paid_amount,
  };
}
