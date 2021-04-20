import 'dart:convert';
import 'package:http/http.dart'
    as http; // add the http plugin in pubspec.yaml file.
import 'package:mysqlcrudislemleri/models/ogrenci.dart';

var url = Uri.parse(
    'https://www.salihceylan.com.tr/mysql_sunucularim/ogrenci_sunucusu.php');

//TODO: METOD İSİMLERİNİ DÜZELT

class OgrenciServisi {
  static const _TABLO_OLUSTUR_ACTION = 'TABLO_OLUSTUR';
  static const _TUM_OGRENCILERI_GETIR_ACTION = 'TUM_OGRENCILERI_GETIR';
  static const _OGRENCI_EKLE_ACTION = 'OGRENCI_EKLE';
  static const _OGRENCI_GUNCELLE_ACTION = 'OGRENCI_GUNCELLE';
  static const _OGRENCI_SIL_ACTION = 'OGRENCI_SIL';

  // Method to create the table Employees.
  static Future<String> createTable() async {
    try {
      // add the parameters to pass to the request.
      var map = Map<String, dynamic>();
      map['action'] = _TABLO_OLUSTUR_ACTION;

      var response = await http.post(url, body: map);
      if (200 == response.statusCode) {
        return response.body;
      }
      throw (response.statusCode);
    } catch (e) {
      e.toString();
      throw (e.toString());
    }
  }

  static Future<List<Ogrenci>> getOgrenciler() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _TUM_OGRENCILERI_GETIR_ACTION;

      var response = await http.post(url, body: map);

      if (200 == response.statusCode) {
        List<Ogrenci> list = parseResponse(response.body);

        return list;
      } else {
        return List.empty();
      }
    } catch (e) {
      print(e.toString());
      return List.empty();
    }
  }

  static List<Ogrenci> parseResponse(String responseBody) {
    var decode = json.decode(responseBody);
    final parsed = decode.cast<Map<String, dynamic>>();
    return parsed.map<Ogrenci>((json) => Ogrenci.fromJson(json)).toList();
  }

  // Method to add employee to the database...
  static Future<String> addOgrenci(Ogrenci ogrenci) async {
    try {
      var response = await http.post(url,
          body: Ogrenci.toJson(ogrenci, _OGRENCI_EKLE_ACTION));

      if (200 == response.statusCode) {
        print(response.body.toString());
        return response.body;
      } else {
        return response.statusCode.toString();
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  // Method to update an Employee in Database...
  static Future<String> updateOgrenci(Ogrenci ogrenci) async {
    try {
      var response = await http.post(url,
          body: Ogrenci.toJson(ogrenci, _OGRENCI_GUNCELLE_ACTION));
      print('updateEmployee Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return response.statusCode.toString();
      }
    } catch (e) {
      return e.toString();
    }
  }

  // Method to Delete an Employee from Database...
  static Future<String> deleteOgrenci(Ogrenci ogrenci) async {
    try {
      var response = await http.post(url,
          body: Ogrenci.toJson(ogrenci, _OGRENCI_SIL_ACTION));

      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error"; // returning just an "error" string to keep this simple...
    }
  }
}
