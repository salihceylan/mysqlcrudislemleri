class Okul {
  String okulKodu;
  String okulAdi;

  Okul({required this.okulKodu, required this.okulAdi});

  factory Okul.fromJson(Map<String, dynamic> json) {
    //todo::
    return Okul(
        okulKodu: json['okulKodu'] as String,
        okulAdi: json['okulAdi'] as String);
  }

  static Map<String, dynamic> toJson(Okul okul, String action) {
    var map = Map<String, dynamic>();

    map['action'] = action;
    map['okulKodu'] = okul.okulKodu.toString();
    map['okulAdi'] = okul.okulAdi.toString();
    return map;
  }
}
