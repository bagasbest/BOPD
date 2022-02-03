import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'database.dart';

class EmployeeEditScreen extends StatefulWidget {
  final String name;
  final String nip;
  final String position;
  final String uid;

  EmployeeEditScreen({
    required this.name,
    required this.nip,
    required this.position,
    required this.uid,
  });

  @override
  _EmployeeEditScreenState createState() => _EmployeeEditScreenState();
}

class _EmployeeEditScreenState extends State<EmployeeEditScreen> {
  final _nameController = TextEditingController();
  final _nipController = TextEditingController();
  final _positionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.name;
    _nipController.text = widget.nip;
    _positionController.text = widget.position;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xfffbbb5b),
        title: const Text(
          'Edit Data Karyawan',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onTap: ()=>Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                /// KOLOM NAMA
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 16, right: 16),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 1),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextFormField(
                    controller: _nameController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      hintText: 'Nama Lengkap',
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Nama Lengkap tidak boleh kosong';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),

                /// KOLOM NIP
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 16, right: 16),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 1),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextFormField(
                    controller: _nipController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      hintText: 'NIP',
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'NIP tidak boleh kosong';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),

                /// KOLOM JABATAN
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 16, right: 16),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 1),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextFormField(
                    controller: _positionController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      hintText: 'Jabatan',
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Jabatan tidak boleh kosong';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),

                /// LOADING INDIKATOR
                Visibility(
                  visible: _visible,
                  child: const SpinKitRipple(
                    color: Color(0xfffbbb5b),
                  ),
                ),

                const SizedBox(
                  height: 16,
                ),

                /// TOMBOL edit / perbarui data karyawan
                SizedBox(
                  width: 250,
                  height: 50,
                  child: RaisedButton(
                    color: const Color(0xfffbbb5b),
                    child: const Text(
                      'Perbarui',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(29)),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _visible = true;
                        });

                        /// simpan perubahan kedalam database
                        DatabaseService.updateEmployee(
                          _nameController.text,
                          _nipController.text,
                          _positionController.text,
                          widget.uid
                        );

                        setState(() {
                          _visible = false;
                          _nameController.text = "";
                          _nipController.text = "";
                          _positionController.text = "";
                          showAlertDialog(context);
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            side: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          backgroundColor: const Color(0xfffbbb5b),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Center(
                child: Text(
                  'Sukses Diperbarui',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.1,
                  right: MediaQuery.of(context).size.width * 0.1,
                ),
                child: const Divider(
                  color: Colors.white,
                  height: 3,
                  thickness: 3,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                'Anda berhasil memperbarui data karyawan ini!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  width: 250,
                  height: 50,
                  child: const Center(
                    child: Text(
                      "Tutup",
                      style: TextStyle(
                        fontSize: 18,
                        letterSpacing: 1,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xfffbbb5b),
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ],
          ),
          elevation: 10,
        );
      },
    );
  }
}
