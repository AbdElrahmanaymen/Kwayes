import 'package:firebase_storage/firebase_storage.dart';

Future<String> downloadUrl(String path) {
  return FirebaseStorage.instance
      .refFromURL('gs://kwayes-a3377.appspot.com/')
      .child(path)
      .getDownloadURL();
}
