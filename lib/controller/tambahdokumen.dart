// import 'package:get/get.dart';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:firebase';

class TambahDokumen {
  List<PlatformFile>? _files;

  // get mountainsRef => null;

  void openFile() async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    // if (_files != null) {
    // File file = File(result?.files.first.path);
    // String? nama = result?.files.first.name;
    //   print(file);
    //   String nama = _files.files.first.name;
    // } else {
    //   // User canceled the picker
    // }

    // final storageRef = FirebaseStorage.instance.ref();
    // final mountainsRef = storageRef.child(nama!);
    // try {
    //   await mountainsRef.putFile(file);
    // } on FirebaseException catch (e) {
    //   // ...
    // }
  }

  Future uploadFile() async {
    final path = '${_files!.first.name}';
    final file = File(_files!.first.path!);

    final ref = FirebaseStorage.instance.ref().putFile(file);
  }
}
