import 'package:flutter/material.dart';
import 'package:mysqlcrudislemleri/models/ogrenci.dart';
import 'package:mysqlcrudislemleri/servisler/ogrenci_servisi.dart';

class OgrenciScreen extends StatefulWidget {
  final String title;

  const OgrenciScreen({Key? key, required this.title}) : super(key: key);

  @override
  _OgrenciScreenState createState() => _OgrenciScreenState();
}

class _OgrenciScreenState extends State<OgrenciScreen> {
  late List<Ogrenci> _ogrenciler;
  late GlobalKey<ScaffoldState> _scaffoldKey;

  // controller for the First Name TextField we are going to create.
  late TextEditingController _adSoyadController,
      _tcKimlikNoController,
      _dogumTarihiController;

  late Ogrenci _selectedOgrenci;
  late bool _isUpdating;
  late String _titleProgress;

  @override
  void initState() {
    super.initState();
    _ogrenciler = [];
    _isUpdating = false;
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey(); // key to get the context to show a SnackBar
    _adSoyadController = TextEditingController();
    _tcKimlikNoController = TextEditingController();
    _dogumTarihiController = TextEditingController();
    _getOgrenci();
  }

  // Method to update title in the AppBar Title
  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }

  _createTable() {
    _showProgress('Creating Table...');
    OgrenciServisi.createTable().then((result) {
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
  _addOgrenci() {
    if (_adSoyadController.text.isEmpty ||
        _tcKimlikNoController.text.isEmpty ||
        _dogumTarihiController.text.isEmpty) {
      print('Empty Fields');
      return;
    }
    _showProgress('Adding Ogrenci...');
    Ogrenci ogrenci = Ogrenci(
        adi_soyadi: _adSoyadController.text,
        tc_kimlik_no: _tcKimlikNoController.text,
        dogum_tarihi: _dogumTarihiController.text);

    OgrenciServisi.addOgrenci(ogrenci).then((result) {
      if ('success' == result) {
        _getOgrenci(); // Refresh the List after adding each Ogrenci...
        _clearValues();
      }
    });
  }

  _getOgrenci() {
    _showProgress('Loading Ogrenci...');
    OgrenciServisi.getOgrenciler().then((ogrenciler) {
      setState(() {
        _ogrenciler = ogrenciler;
      });
      _showProgress(widget.title); // Reset the title...
      print("Length ${ogrenciler.length}");
    });
  }

  _updateOgrenci(Ogrenci ogrenci) {
    setState(() {
      _isUpdating = true;
    });
    _showProgress('Updating Ogrenci...');
    ogrenci.adi_soyadi = _adSoyadController.text;
    ogrenci.tc_kimlik_no = _tcKimlikNoController.text;
    ogrenci.dogum_tarihi = _dogumTarihiController.text;

    OgrenciServisi.updateOgrenci(ogrenci).then((result) {
      if ('success' == result) {
        _getOgrenci(); // Refresh the list after update
        setState(() {
          _isUpdating = false;
        });
        _clearValues();
      }
    });
  }

  _deleteOgrenci(Ogrenci ogrenci) {
    _showProgress('Deleting ogrenci...');
    OgrenciServisi.deleteOgrenci(ogrenci).then((result) {
      if ('success' == result) {
        _getOgrenci(); // Refresh after delete...
      }
    });
  }

// Method to clear TextField values
  _clearValues() {
    _adSoyadController.text = '';
    _tcKimlikNoController.text = '';
    _tcKimlikNoController.text = '';
  }

  _showValues(Ogrenci ogrenci) {
    _adSoyadController.text = ogrenci.adi_soyadi;
    _tcKimlikNoController.text = ogrenci.tc_kimlik_no;
    _dogumTarihiController.text = ogrenci.dogum_tarihi;
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
              label: Text('ÖĞRENCİ NO'),
            ),
            DataColumn(
              label: Text('ADI SOYADI'),
            ),
            DataColumn(
              label: Text('TC KİMLİK NO'),
            ),
            DataColumn(
              label: Text('DOĞUM TARİHİ'),
            ),
            // Lets add one more column to show a delete button
            DataColumn(
              label: Text('SİL'),
            )
          ],
          rows: _ogrenciler
              .map(
                (ogrenci) => DataRow(cells: [
                  DataCell(
                    Text(ogrenci.ogrenci_no.toString()),
                    // Add tap in the row and populate the
                    // textfields with the corresponding values to update
                    onTap: () {
                      _showValues(ogrenci);
                      // Set the Selected Ogrenci to Update
                      _selectedOgrenci = ogrenci;
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(
                    Text(
                      ogrenci.adi_soyadi.toUpperCase(),
                    ),
                    onTap: () {
                      _showValues(ogrenci);
                      // Set the Selected Ogrenci to Update
                      _selectedOgrenci = ogrenci;
                      // Set flag updating to true to indicate in Update Mode
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(
                    Text(
                      ogrenci.tc_kimlik_no.toUpperCase(),
                    ),
                    onTap: () {
                      _showValues(ogrenci);
                      // Set the Selected Ogrenci to Update
                      _selectedOgrenci = ogrenci;
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(
                    Text(
                      ogrenci.dogum_tarihi.toUpperCase(),
                    ),
                    onTap: () {
                      _showValues(ogrenci);
                      // Set the Selected Ogrenci to Update
                      _selectedOgrenci = ogrenci;
                      setState(() {
                        _isUpdating = true;
                      });
                    },
                  ),
                  DataCell(IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deleteOgrenci(ogrenci);
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
              _getOgrenci();
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
                controller: _adSoyadController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Adı Soyadı',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: _tcKimlikNoController,
                decoration: InputDecoration.collapsed(
                  hintText: 'TC Kimlik No',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: _dogumTarihiController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Doğum Tarihi',
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
                          _updateOgrenci(_selectedOgrenci);
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
          _addOgrenci();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
