import 'package:flutter/material.dart';

class CustomDialog {
  final BuildContext context;
  final String? title;
  final String? desc;

  /// Btn OK props
  final String? btnOkText;
  final Function? btnOkOnPress;
  final Color? btnOkColor;

  /// Btn Cancel props
  final String? btnCancelText;
  final Function? btnCancelOnPress;
  final Color? btnCancelColor;

  /// Barrier Dismissible
  final bool dismissOnTouchOutside;

  /// Callback to execute after dialog get dismissed
  final Function()? onDismissCallback;

  ///Border Radius for the Dialog
  final BorderRadiusGeometry? dialogBorderRadius;

  /// Padding off inner content of Dialog
  final EdgeInsetsGeometry? padding;

  /// To use the Rootnavigator
  final bool useRootNavigator;

  /// For Auto Hide Dialog after some Duration.
  final Duration? autoHide;

  ///Control if Dialog is dismiss by back key.
  final bool dismissOnBackKeyPress;

  ///Max with of entire Dialog.
  final double? width;

  ///Border Radius for built in buttons.
  final BorderRadiusGeometry? buttonsBorderRadius;

  ///TextStyle for built in buttons.
  final TextStyle? buttonsTextStyle;

  /// Control if close icon is appear.
  final bool showCloseIcon;

  /// Custom closeIcon.
  final Widget? closeIcon;

  /// Custom background color for dialog + header
  final Color? dialogBackgroundColor;

  /// Set BorderSide of DialogShape
  final BorderSide? borderSide;

  CustomDialog({
    required this.context,
    this.title,
    this.desc,
    this.btnOkText,
    this.btnOkOnPress,
    this.btnOkColor,
    this.btnCancelText,
    this.btnCancelOnPress,
    this.btnCancelColor,
    this.onDismissCallback,
    this.dismissOnTouchOutside = true,
    this.padding,
    this.useRootNavigator = false,
    this.autoHide,
    this.dismissOnBackKeyPress = true,
    this.width,
    this.dialogBorderRadius,
    this.buttonsBorderRadius,
    this.showCloseIcon = false,
    this.closeIcon,
    this.dialogBackgroundColor,
    this.borderSide,
    this.buttonsTextStyle,
  });

  bool isDismissedBySystem = false;

  Future show() => showDialog(
      context: context,
      useRootNavigator: useRootNavigator,
      barrierDismissible: dismissOnTouchOutside,
      builder: (BuildContext context) {
        if (autoHide != null) {
          Future.delayed(autoHide!).then((value) => dismiss());
        }
        return AlertDialog(
          insetPadding: const EdgeInsets.all(20),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          scrollable: true,
          content: _dialog,
        );
      }).then((_) {
    isDismissedBySystem = true;
    if (onDismissCallback != null) onDismissCallback?.call();
  });

  Widget get _dialog => WillPopScope(
    onWillPop: onWillPop,
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500),
      child: SizedBox(
        width: 500,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title != null)
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Text(
                  title!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.grey.shade800
                  ),
                ),
              ),
            if (desc != null)
              Flexible(
                fit: FlexFit.loose,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Text(
                    desc!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.grey
                    ),
                  ),
                ),
              ),
            if (desc != null)
              const SizedBox(
                height: 16.0,
              ),
            SizedBox(
              height: 50,
              child: ListView(
                padding: const EdgeInsets.only(top: 10),
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                reverse: true,
                children: [
                  _buttonOk,
                  const SizedBox(width: 10),
                  _buttonCancel,
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );

  Widget get _buttonOk => ElevatedButton(
    style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: btnOkColor,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        )),
    onPressed: () {
      dismiss();
      btnOkOnPress?.call();
    },
    child: Text(
      btnOkText ?? 'Okay',
      textAlign: TextAlign.center,
      style: buttonsTextStyle ??
          const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
    ),
  );

  Widget get _buttonCancel => ElevatedButton(
    style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: btnCancelColor ?? Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        )),
    onPressed: () {
      dismiss();
      btnCancelOnPress?.call();
    },
    child: Text(
      btnCancelText ?? 'Cancel',
      textAlign: TextAlign.center,
      style: buttonsTextStyle ??
          const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
    ),
  );

  dismiss() {
    if (!isDismissedBySystem) {
      Navigator.of(context, rootNavigator: useRootNavigator).pop();
    }
  }

  Future<bool> onWillPop() async => dismissOnBackKeyPress;
}
