import 'dart:convert';
import 'package:http/http.dart'
    as http; // add the http plugin in pubspec.yaml file.
import 'package:mysqlcrudislemleri/models/employee.dart';

var url = Uri.parse(
    'https://www.salihceylan.com.tr/mysql_sunucularim/employee_sunucusu.php');

class EmployeeServices {
  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _ADD_EMP_ACTION = 'ADD_EMP';
  static const _UPDATE_EMP_ACTION = 'UPDATE_EMP';
  static const _DELETE_EMP_ACTION = 'DELETE_EMP';

  // Method to create the table Employees.
  static Future<String> createTable() async {
    try {
      // add the parameters to pass to the request.
      var map = Map<String, dynamic>();
      map['action'] = _CREATE_TABLE_ACTION;

      var response = await http.post(url, body: map);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      }
      throw (response.statusCode);
    } catch (e) {
      e.toString();
      throw (e.toString());
    }
  }

  static Future<List<Employee>> getEmployees() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;

      var response = await http.post(url, body: map);

      if (200 == response.statusCode) {
        List<Employee> list = parseResponse(response.body);
        return list;
      } else {
        return List.empty();
      }
    } catch (e) {
      print(e.toString());
      return List.empty();
    }
  }

  static List<Employee> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Employee>((json) => Employee.fromJson(json)).toList();
  }

  // Method to add employee to the database...
  static Future<String> addEmployee(Employee e) async {
    try {
      var response =
          await http.post(url, body: Employee.toJson(e, _ADD_EMP_ACTION));

      if (200 == response.statusCode) {
        return response.body;
      } else {
        return response.statusCode.toString();
      }
    } catch (e) {
      return e.toString();
    }
  }

  // Method to update an Employee in Database...
  static Future<String> updateEmployee(Employee e) async {
    try {
      var response =
          await http.post(url, body: Employee.toJson(e, _UPDATE_EMP_ACTION));
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
  static Future<String> deleteEmployee(Employee e) async {
    try {
      var response =
          await http.post(url, body: Employee.toJson(e, _DELETE_EMP_ACTION));

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
