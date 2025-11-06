import 'dart:convert';

import 'package:crypto/crypto.dart';

String hashMD5(String input) {
  List<int> bytes = utf8.encode(input); // Encode the string to UTF-8 bytes
  Digest md5Hash = md5.convert(bytes); // Calculate the MD5 hash
  String hexDigest = md5Hash.toString();

  return hexDigest;
}

String hashSHA512(String input) {
  List<int> bytes = utf8.encode(input); // Encode the string to UTF-8 bytes
  Digest sha512hash = sha512.convert(bytes);
  String hexDigest = sha512hash.toString();

  return hexDigest;
}
