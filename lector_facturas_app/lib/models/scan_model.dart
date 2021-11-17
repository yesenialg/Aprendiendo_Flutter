import 'dart:convert';

ScanModel scanModelFromJson(String str) => ScanModel.fromJson(json.decode(str));

String scanModelToJson(ScanModel data) => json.encode(data.toJson());

class ScanModel {
  ScanModel({
    this.id = 0,
    required this.cufe,
    this.fecha = '',
    this.total = 0,
    this.num_factura = '',
    this.doc = '',
  });

  int id;
  String cufe;
  String fecha;
  int total;
  String num_factura;
  String doc;

  factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        id: json["id"],
        cufe: json["cufe"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cufe": cufe,
      };
}
