import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:foodfinder/ui/screens/widgets/dialog/info_dialog.dart';
import 'package:foodfinder/ui/screens/widgets/dialog/loading_dialog.dart';

class DialogUtils {
  static DialogUtils instance = DialogUtils();

  void showInfo(
      BuildContext context, String message, IconData icon, String buttonText,
      {Function onClick}) {
    showModal(
        context: context,
        configuration:
            FadeScaleTransitionConfiguration(barrierDismissible: false),
        builder: (context) {
          return InfoDialog(
            text: message,
            onClickOk: () =>
                onClick != null ? onClick() : Navigator.pop(context),
            icon: icon,
            clickText: buttonText,
          );
        });
  }

  void showChoose(
      BuildContext context, String message, IconData icon, String buttonText,
      {Function onClick}) {
    showModal(
        context: context,
        configuration:
            FadeScaleTransitionConfiguration(barrierDismissible: false),
        builder: (context) {
          return InfoDialog(
            text: message,
            onClickOk: () =>
                onClick != null ? onClick() : Navigator.pop(context),
            clickText: buttonText,
            icon: icon,
          );
        });
  }

  void showLoading(BuildContext context, String message) {
    showModal(
      context: context,
      configuration:
          FadeScaleTransitionConfiguration(barrierDismissible: false),
      builder: (context) {
        return LoadingDialog(
          text: message,
        );
      },
    );
  }
}
