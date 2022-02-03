import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bopd/login_screen.dart';

class DatabaseService {
  static void addEmployee(String name, String nip, String position) {
    try {
      var employeeId = DateTime.now().millisecondsSinceEpoch;
      FirebaseFirestore.instance
          .collection('employee')
          .doc(employeeId.toString())
          .set(
        {
          'uid': employeeId.toString(),
          'name': name,
          'nip': nip,
          'position': position,
        },
      );
    } catch (error) {
      toast(
          'Gagal menambahkan karyawan baru, silahkan cek koneksi anda dan coba lagi nanti');
    }
  }

  static void updateEmployee(String name, String nip, String position, String uid) {
    try {
      FirebaseFirestore.instance
          .collection('employee')
          .doc(uid.toString())
          .update(
        {
          'name': name,
          'nip': nip,
          'position': position,
        },
      );
    } catch (error) {
      toast(
          'Gagal memperbarui data karyawan, silahkan cek koneksi anda dan coba lagi nanti');
    }
  }

  /// hapus data karyawan
  static Future<void> deleteEmployee(String uid) async {
    try {
      await FirebaseFirestore.instance
          .collection('employee')
          .doc(uid.toString())
          .delete();

      toast(
          'Berhasil menghapus data karyawan');

    } catch (error) {
      toast(
          'Gagal menghapus data karyawan, silahkan cek koneksi anda dan coba lagi nanti');
    }
  }
}
