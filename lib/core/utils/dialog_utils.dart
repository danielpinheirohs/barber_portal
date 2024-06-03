import 'package:barber_portal/shared/widgets/brb_button.dart';
import 'package:barber_portal/shared/widgets/brb_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DialogUtils {
  static showInformativeSuccessDialog(BuildContext context, String message) {
    _showDialog(context, 'Sucesso!', message);
  }

  static showInformativeErrorDialog(BuildContext context, String message) {
    _showDialog(context, 'Ops!', message);
  }

  static _showDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Center(
            child: Column(
          children: [
            Text(title),
            const Divider(),
          ],
        )),
        content: Container(
          constraints: const BoxConstraints(maxWidth: 500, maxHeight: 500),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
            child: BRBText.bodyLarge(text: message),
          ),
        ),
        actions: [
          BRBButton.large(
            onPressed: () => context.pop(),
            text: 'Ok',
            height: 45,
          )
        ],
      ),
    );
  }

    static showBottomMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.grey[300],
        content: Center(
          child: BRBText.bodyLarge(text: message),
        ),
      ),
    );
  }

  static showPopUp(BuildContext context, Widget? widget) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        content: widget,
      ),
    );
  }
}
