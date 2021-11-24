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
    this.establecimiento = '',
    this.tipo= '',

  });

  int id;
  String cufe;
  String fecha;
  double total;
  String num_factura;
  String doc;
  String establecimiento;
  String tipo;

  factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        id: json["id"],
        cufe: json["cufe"],
        fecha: json["fecha"],
        total: json["total"],
        num_factura: json["num_factura"],
        doc: json["doc"],
        establecimiento: json["establecimiento"],
        tipo: json["tipo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cufe": cufe,
        "fecha": fecha,
        "total": total,
        "num_factura": num_factura,
        "doc": doc,
        "establecimiento": establecimiento,
        "tipo":tipo
      };
}
