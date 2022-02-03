import 'package:bopd/employee_add_screen.dart';
import 'package:bopd/employee_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Route route = MaterialPageRoute(
              builder: (context) => const EmployeeAddScreen());
          Navigator.push(context, route);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.pink,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 70,
              color: const Color(0xfffbbb5b),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 23,
                left: 16,
                right: 16,
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Daftar Pegawai',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                    GestureDetector(
                      child: const Icon(
                        Icons.logout,
                        color: Colors.red,
                      ),
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();

                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => const LoginScreen()),
                                (Route<dynamic> route) => false);
                      },
                    ),
                  ],
                ),
              ),
            ),

            /// tampilkan semua data karyawan yang telah ditambahkan sebelumnya, berasarl dari database
            Container(
              margin: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 88,
                bottom: 90,
              ),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('employee')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return (snapshot.data!.size > 0)
                        ? ListOfEmployee(
                            document: snapshot.data!.docs,
                          )
                        : _emptyData();
                  } else {
                    return _emptyData();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _emptyData() {
    return const Center(
      child: Text(
        'Tidak Ada Karyawan\nTerdaftar',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black54,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }
}
