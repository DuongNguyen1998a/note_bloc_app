import 'package:flutter/material.dart';

class SupportUtils {
  static showModalBottomSheetDialog(BuildContext context, Widget child) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(25),
            topLeft: Radius.circular(25),
          ),
        ),
        builder: (context) {
          return child;
        });
  }

  static showSnackBarDialog(
      BuildContext context, String message, Widget? icon) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            icon ?? const SizedBox(),
            const SizedBox(
              width: 10,
            ),
            Text(
              message,
              maxLines: 2,
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static BoxDecoration backgroundColor() {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.blue, Colors.purple],
      ),
    );
  }
}
