// To parse this JSON data, do
//
//     final resBerita = resBeritaFromJson(jsonString);

import 'dart:convert';

ResBerita resBeritaFromJson(String str) => ResBerita.fromJson(json.decode(str));

String resBeritaToJson(ResBerita data) => json.encode(data.toJson());

class ResBerita {
  bool? isSuccess;
  String? message;
  List<Berita>? data;

  ResBerita({
    this.isSuccess,
    this.message,
    this.data,
  });

  factory ResBerita.fromJson(Map<String, dynamic> json) => ResBerita(
        isSuccess: json["isSuccess"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Berita>.from(json["data"]!.map((x) => Berita.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "isSuccess": isSuccess,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Berita {
  String? id;
  String? judul;
  String? isiBerita;
  String? gambarBerita;
  DateTime? tglBerita;

  Berita({
    this.id,
    this.judul,
    this.isiBerita,
    this.gambarBerita,
    this.tglBerita,
  });

  factory Berita.fromJson(Map<String, dynamic> json) => Berita(
        id: json["id"],
        judul: json["judul"],
        isiBerita: json["isi_berita"],
        gambarBerita: json["gambar_berita"],
        tglBerita: json["tgl_berita"] == null
            ? null
            : DateTime.parse(json["tgl_berita"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "judul": judul,
        "isi_berita": isiBerita,
        "gambar_berita": gambarBerita,
        "tgl_berita": tglBerita?.toIso8601String(),
      };
}
