import 'package:flutter/material.dart';
import 'package:mysqlcrudislemleri/models/employee.dart';
import 'package:mysqlcrudislemleri/servisler/employee_service.dart';

class EmployeesScreen extends StatefulWidget {
  final String title;

  const EmployeesScreen({Key? key, required this.title}) : super(key: key);

  @override
  _EmployeesScreenState createState() => _EmployeesScreenState();
}

class _EmployeesScreenState extends State<EmployeesScreen> {
  late List<Employee> _employees;
  late GlobalKey<ScaffoldState> _scaffoldKey;

  // controller for the First Name TextField we are going to create.
  late TextEditingController _firstNameController;

  // controller for the Last Name TextField we are going to create.
  late TextEditingController _lastNameController;
  late Employee _selectedEmployee;
  late bool _isUpdating;
  late String _titleProgress;

  @override
  void initState() {
    super.initState();
    _employees = [];
    _isUpdating = false;
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey(); // key to get the context to show a SnackBar
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _getEmployees();
  }

  // Method to update title in the AppBar Title
  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }

  _createTable() {
    _showProgress('Creating Table...');
    EmployeeServices.createTable().then((result) {
      print(result);

      try {
        if ('success' == result) {
          // Table is created successfully.

          _showProgress(widget.title);
        }
      } catch (e) {
        print(e.toString());
      }
    });
  }

// Now lets add an Employee
  _addEmployee() {
    if (_firstNameController.text.isEmpty || _lastNameController.text.isEmpty) {
      print('Empty Fields');
      return;
    }
    _showProgress('Adding Ogrenci...');
    Employee e = Employee(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text);

    EmployeeServices.addEmployee(e).then((result) {
      if ('success' == result) {
        _getEmployees(); // Refresh the List after adding each employee...
        _clearValues();
      }
    });
  }

  _getEmployees() {
    _showProgress('Loading Employees...');
    EmployeeServices.getEmployees().then((employees) {
      setState(() {
        _employees = employees;
      });
      _showProgress(widget.title); // Reset the title...
      print("Length ${employees.length}");
    });
  }

  _updateEmployee(Employee e) {
    setState(() {
      _isUpdating = true;
    });
    _showProgress('Updating Employee...');
    e.firstName = _firstNameController.text;
    e.lastName = _lastNameController.text;
    e.salary = 5000.toString();

    EmployeeServices.updateEmployee(e).then((result) {
      if ('success' == result) {
        _getEmployees(); // Refresh the list after update
        setState(() {
          _isUpdating = false;
        });
        _clearValues();
      }
    });
  }

  _deleteEmployee(Employee e) {
    _showProgress('Deleting Employee...');
    EmployeeServices.deleteEmployee(e).then((result) {
      if ('success' == result) {
        _getEmployees(); // Refresh after delete...
      }
    });
  }

// Method to clear TextField values
  _clearValues() {
    _firstNameController.text = '';
    _lastNameController.text = '';
  }

  _showValues(Employee employee) {
    _firstNameController.text = employee.firstName;
    _lastNameController.text = employee.lastName;
  }

// Let's create a DataTable and show the employee list in it.
  SingleChildScrollView _dataBody() {
    // Both Vertical and Horozontal Scrollview for the DataTable to
    // scroll both Vertical and Horizontal...
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(
              label: Text('ID'),
            ),
            DataColumn(
              label: Text('FIRST NAME'),
            ),
            DataColumn(
              label: Text('LAST NAME'),
            ),
            DataColumn(
              label: Text('SALARY'),
            ),
            // Lets add one more column to show a delete button
            DataColumn(
              label: Text('DELETE'),
            )
          ],
          rows: _employees.map((employee) {
            double maas = double.parse(employee.salary ?? "0.0");
            double primliMaas = maas + 1200.0;
            print(primliMaas.toString());
            return DataRow(cells: [
              DataCell(
                Text(employee.id.toString()),
                // Add tap in the row and populate the
                // textfields with the corresponding values to update
                onTap: () {
                  _showValues(employee);
                  // Set the Selected employee to Update
                  _selectedEmployee = employee;
                  setState(() {
                    _isUpdating = true;
                  });
                },
              ),
              DataCell(
                Text(
                  employee.firstName.toUpperCase(),
                ),
                onTap: () {
                  _showValues(employee);
                  // Set the Selected employee to Update
                  _selectedEmployee = employee;
                  // Set flag updating to true to indicate in Update Mode
                  setState(() {
                    _isUpdating = true;
                  });
                },
              ),
              DataCell(
                Text(
                  employee.lastName.toUpperCase(),
                ),
                onTap: () {
                  _showValues(employee);
                  // Set the Selected employee to Update
                  _selectedEmployee = employee;
                  setState(() {
                    _isUpdating = true;
                  });
                },
              ),
              DataCell(
                Text(
                  employee.salary ?? " ",
                ),
                onTap: () {
                  _showValues(employee);
                  // Set the Selected employee to Update
                  _selectedEmployee = employee;
                  setState(() {
                    _isUpdating = true;
                  });
                },
              ),
              DataCell(IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  _deleteEmployee(employee);
                },
              ))
            ]);
          }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(_titleProgress), // we show the progress in the title...
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _createTable();
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _getEmployees();
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: _firstNameController,
                decoration: InputDecoration.collapsed(
                  hintText: 'First Name',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: _lastNameController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Last Name',
                ),
              ),
            ),
            // Add an update button and a Cancel Button
            // show these buttons only when updating an employee
            _isUpdating
                ? Row(
                    children: <Widget>[
                      MaterialButton(
                        child: Text('UPDATE'),
                        onPressed: () {
                          _updateEmployee(_selectedEmployee);
                        },
                      ),
                      MaterialButton(
                        child: Text('CANCEL'),
                        onPressed: () {
                          setState(() {
                            _isUpdating = false;
                          });
                          _clearValues();
                        },
                      ),
                    ],
                  )
                : Container(),
            Expanded(
              child: _dataBody(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addEmployee();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
