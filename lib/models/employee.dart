class Employee {
  String? id;
  String firstName;
  String lastName;

  Employee({this.id, required this.firstName, required this.lastName});

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
    );
  }

  static Map<String, dynamic> toJson(Employee e, String action) {
    var map = Map<String, dynamic>();

    map['action'] = action;
    map['emp_id'] = e.id.toString();
    map['first_name'] = e.firstName.toString();
    map['last_name'] = e.lastName.toString();
    return map;
  }
}
