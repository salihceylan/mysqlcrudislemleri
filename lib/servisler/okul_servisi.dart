import 'dart:convert';
import 'package:http/http.dart'
    as http; // add the http plugin in pubspec.yaml file.
import 'package:mysqlcrudislemleri/models/okul.dart';

var url = Uri.parse(
    'https://www.salihceylan.com.tr/mysql_sunucularim/okul_sunucusu.php');

//TODO: METOD İSİMLERİNİ DÜZELT

class OkulServisi {
  static const _TABLO_OLUSTUR_ACTION = 'TABLO_OLUSTUR';
  static const _TUM_OKULLARI_GETIR_ACTION = 'TUM_OKULLARI_GETIR';
  static const _OKUL_EKLE_ACTION = 'OKUL_EKLE';
  static const _OKUL_GUNCELLE_ACTION = 'OKUL_GUNCELLE';
  static const _OKUL_SIL_ACTION = 'OKUL_SIL';

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

  static Future<List<Okul>> getOkullar() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _TUM_OKULLARI_GETIR_ACTION;

      var response = await http.post(url, body: map);

      if (200 == response.statusCode) {
        List<Okul> list = parseResponse(response.body);

        return list;
      } else {
        return List.empty();
      }
    } catch (e) {
      print(e.toString());
      return List.empty();
    }
  }

  static List<Okul> parseResponse(String responseBody) {
    var decode = json.decode(responseBody);
    final parsed = decode.cast<Map<String, dynamic>>();
    return parsed.map<Okul>((json) => Okul.fromJson(json)).toList();
  }

  // Method to add employee to the database...
  static Future<String> addOkul(Okul okul) async {
    try {
      var response =
          await http.post(url, body: Okul.toJson(okul, _OKUL_EKLE_ACTION));

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
  static Future<String> updateOkul(Okul okul) async {
    try {
      var response =
          await http.post(url, body: Okul.toJson(okul, _OKUL_GUNCELLE_ACTION));

      print(okul.okulKodu.toString());
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
  static Future<String> deleteOkul(Okul okul) async {
    try {
      var response =
          await http.post(url, body: Okul.toJson(okul, _OKUL_SIL_ACTION));

      if (200 == response.statusCode) {
        return response.body;
      } else {
        return response.statusCode.toString();
      }
    } catch (e) {
      return e.toString();
    }
  }
}
