import 'package:bopd/database.dart';
import 'package:bopd/employee_edit_screen.dart';
import 'package:bopd/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListOfEmployee extends StatelessWidget {
  final List<DocumentSnapshot> document;

  const ListOfEmployee({required this.document});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: document.length,
      itemBuilder: (BuildContext context, int i) {
        String name = '' + document[i]['name'];
        String nip = '' + document[i]['nip'];
        String position = '' + document[i]['position'];
        String uid = '' + document[i]['uid'];
        return Card(
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              margin: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 16,),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Route route = MaterialPageRoute(
                                    builder: (context) => EmployeeEditScreen(
                                      name: name,
                                      nip: nip,
                                      position: position,
                                      uid: uid,
                                    ),
                                  );
                                  Navigator.push(context, route);
                                },
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.orangeAccent,
                                ),
                              ),
                              const SizedBox(width: 10,),
                              GestureDetector(
                                onTap: (){
                                  _deleteEmployee(context, uid);
                                },
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              )
                            ],
                          ),
                        ),
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Text(
                          'NIP        : $nip',
                          style: const TextStyle(
                          ),
                        ),
                        Text(
                          'Jabatan: $position',
                          style: const TextStyle(
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
        );
      },
    );
  }


  _deleteEmployee(BuildContext context, String uid) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: const [
              Text(
                'Konfirmasi Menghapus',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ],
          ),
          content: const Text(
              'Apakah anda yakin ingin menghapus data karyawan ini ?'),
          actions: [
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: () async {
                DatabaseService.deleteEmployee(uid);

                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                        (Route<dynamic> route) => false);
              },
            ),
          ],
        );
      },
    );
  }
}
