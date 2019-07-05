import 'package:fluttertoast/fluttertoast.dart';

void toast(
  final String message, {
  final Toast toastLength = Toast.LENGTH_SHORT,
  final ToastGravity gravity = ToastGravity.BOTTOM,
}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: toastLength,
    gravity: gravity,
  );
}
