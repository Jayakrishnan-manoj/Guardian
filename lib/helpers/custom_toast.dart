import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Toasts {
  showErrorToast(BuildContext context, String message) {
    FToast fToast = FToast();
    fToast.init(context);
    Widget toast = Container(
      width: MediaQuery.sizeOf(context).width * 0.8,
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.redAccent,
      ),
      child: Center(
        child: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 3),
    );
  }

  showSuccessToast(BuildContext context, String message) {
    FToast fToast = FToast();
    fToast.init(context);
    Widget toast = Container(
      width: MediaQuery.sizeOf(context).width * 0.8,
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.greenAccent,
      ),
      child: Center(
        child: Text(
          message,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 3),
    );
  }


}
