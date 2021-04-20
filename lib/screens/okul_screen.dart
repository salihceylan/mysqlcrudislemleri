import 'package:flutter/material.dart';
import 'package:mysqlcrudislemleri/models/okul.dart';
import 'package:mysqlcrudislemleri/servisler/okul_servisi.dart';

class OkulScreen extends StatefulWidget {
  final String title;

  const OkulScreen({Key? key, required this.title}) : super(key: key);

  @override
  _OkulScreenState createState() => _OkulScreenState();
}

class _OkulScreenState extends State<OkulScreen> {
  late List<Okul> _okullar;
  late GlobalKey<ScaffoldState> _scaffoldKey;

  // controller for the First Name TextField we are going to create.
  late TextEditingController _okulKoduController, _okulAdiController;

  late Okul _selectedOkul;
  late bool _isUpdating;
  late String _titleProgress;

  @override
  void initState() {
    super.initState();
    _okullar = [];
    _isUpdating = false;
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey(); // key to get the context to show a SnackBar
    _okulKoduController = TextEditingController();
    _okulAdiController = TextEditingController();

    _getOkullar();
  }

  // Method to update title in the AppBar Title
  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }

  _createTable() {
    _showProgress('Creating Okul Table...');
    OkulServisi.createTable().then((result) {
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

// Now lets add an Ogrenci
  _addOkul() {
    if (_okulKoduController.text.isEmpty || _okulAdiController.text.isEmpty) {
      print('Empty Fields');
      return;
    }
    _showProgress('Adding OKUL...');
    Okul okul = Okul(
        okulKodu: _okulKoduController.text.toString(),
        okulAdi: _okulAdiController.text.toString());

    OkulServisi.addOkul(okul).then((result) {
      if ('success' == result.toString()) {
        print(result.toString());
      }
      _getOkullar();
      _clearValues();
    });
  }

  _getOkullar() {
    _showProgress('Loading Ogrenci...');
    OkulServisi.getOkullar().then((okullar) {
      setState(() {
        _okullar = okullar;
      });
      _showProgress(widget.title); // Reset the title...
      print("Length ${okullar.length}");
    });
  }

  _updateOkul(Okul okul) {
    setState(() {
      _isUpdating = true;
    });
    _showProgress('Updating Ogrenci...');
    okul.okulKodu = _okulKoduController.text;
    okul.okulAdi = _okulAdiController.text;

    OkulServisi.updateOkul(okul).then((result) {
      if ('success' == result) {
        _getOkullar(); // Refresh the list after update
        setState(() {
          _isUpdating = false;
        });
        _clearValues();
      }
    });
  }

  _deleteOkul(Okul okul) {
    _showProgress('Deleting okul...');
    OkulServisi.deleteOkul(okul).then((result) {
      if ('success' == result) {
        _getOkullar(); // Refresh after delete...
      }
    });
  }

// Method to clear TextField values
  _clearValues() {
    _okulKoduController.text = '';
    _okulAdiController.text = '';
  }

  _showValues(Okul okul) {
    _okulKoduController.text = okul.okulKodu;
    _okulAdiController.text = okul.okulAdi;
  }

// Let's create a DataTable and show the Ogrenci list in it.
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
              label: Text('OKUL KODU'),
            ),
            DataColumn(
              label: Text('OKUL ADI'),
            ),
            // Lets add one more column to show a delete button
            DataColumn(
              label: Text('SİL'),
            )
          ],
          rows: _okullar
              .map(
                (okul) => DataRow(cells: [
                  DataCell(
                    Text(okul.okulKodu.toString()),
                    // Add tap in the row and populate the
                    // textfields with the corresponding values to update
                    onTap: () {
                      _showValues(okul);
                      // Set the Selected Ogrenci to Update
                      _selectedOkul = okul;
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(
                    Text(
                      okul.okulAdi.toUpperCase(),
                    ),
                    onTap: () {
                      _showValues(okul);
                      // Set the Selected Ogrenci to Update
                      _selectedOkul = okul;
                      // Set flag updating to true to indicate in Update Mode
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deleteOkul(okul);
                    },
                  ))
                ]),
              )
              .toList(),
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
              _getOkullar();
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
                controller: _okulKoduController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Okul Kodu',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: _okulAdiController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Okul Adı',
                ),
              ),
            ),

            // Add an update button and a Cancel Button
            // show these buttons only when updating an Ogrenci
            _isUpdating
                ? Row(
                    children: <Widget>[
                      MaterialButton(
                        child: Text('Güncelle'),
                        onPressed: () {
                          _updateOkul(_selectedOkul);
                        },
                      ),
                      MaterialButton(
                        child: Text('İptal Et'),
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
          _addOkul();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
