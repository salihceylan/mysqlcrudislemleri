class Ogrenci {
  // ignore: non_constant_identifier_names
  String? ogrenci_no;
  //ignore: non_constant_identifier_names
  String adi_soyadi;
  //ignore: non_constant_identifier_names
  String tc_kimlik_no;
  //ignore: non_constant_identifier_names
  String dogum_tarihi;

  Ogrenci(
      // ignore: non_constant_identifier_names
      {this.ogrenci_no,
      //ignore: non_constant_identifier_names
      required this.adi_soyadi,
      //ignore: non_constant_identifier_names
      required this.tc_kimlik_no,
      //ignore: non_constant_identifier_names
      required this.dogum_tarihi});

  factory Ogrenci.fromJson(Map<String, dynamic> json) {
    //todo::
    return Ogrenci(
        ogrenci_no: json['ogrenci_no'],
        adi_soyadi: json['adi_soyadi'],
        tc_kimlik_no: json['tc_kimlik_no'],
        dogum_tarihi: json['dogum_tarihi']);
  }

  static Map<String, dynamic> toJson(Ogrenci ogrenci, String action) {
    var map = Map<String, dynamic>();

    map['action'] = action;
    map['ogrenci_no'] = ogrenci.ogrenci_no.toString();
    map['adi_soyadi'] = ogrenci.adi_soyadi.toString();
    map['tc_kimlik_no'] = ogrenci.tc_kimlik_no.toString();
    map['dogum_tarihi'] = ogrenci.dogum_tarihi.toString();
    return map;
  }
}
