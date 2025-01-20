import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ShowToast {
  const ShowToast._();
  static showCustomSnackBar({required String message}) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.close, color: Colors.white), // Adding an icon
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                style: TextStyle(color: Colors.white),
                message.toString(), // Using the passed parameter
              ),
            ),
          ],
        ),
        backgroundColor: Colors.red, // Changing background color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Setting the border radius
        ),
        behavior:
            SnackBarBehavior.floating, // Making SnackBar float above content
      ),
    );
  }

  static showSuccessSnackBar({required String message}) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.close, color: Colors.white), // Adding an icon
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message.toString(),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.green, // Changing background color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Setting the border radius
        ),
        behavior:
            SnackBarBehavior.floating, // Making SnackBar float above content
      ),
    );
  }

  static void showToastErrorTop({
    required String message,
    int? seconds,
  }) =>
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: seconds ?? 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16,
      );

  static void showToastSuccessTop({
    required String message,
    int? seconds,
  }) =>
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: seconds ?? 3,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16,
      );
}
