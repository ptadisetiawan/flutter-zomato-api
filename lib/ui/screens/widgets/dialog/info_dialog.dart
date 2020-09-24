import 'package:flutter/material.dart';
import 'package:foodfinder/ui/constant/constant.dart';

class InfoDialog extends StatelessWidget {
  String text;
  String clickText;
  IconData icon;
  Function onClickOk;
  Function onClickCancel;
  InfoDialog({
    @required this.text,
    this.clickText = "OK",
    @required this.icon,
    @required this.onClickOk,
    this.onClickCancel,
  });
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Center(
          child: Icon(
        icon,
        color: primaryColor,
        size: 25,
      )),
      content: Text(
        text,
        style: TextStyle(color: Colors.black87, fontSize: 16),
      ),
      actions: [
        onClickCancel != null
            ? OutlineButton(
                onPressed: () => onClickCancel(),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                borderSide: BorderSide(color: primaryColor),
                child: Text(
                  "Batal",
                  style: TextStyle(
                      color: primaryColor, fontWeight: FontWeight.w600),
                ),
              )
            : SizedBox(),
        RaisedButton(
          color: primaryColor,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          onPressed: () => onClickOk(),
          child: Text(
            clickText,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        )
      ],
    );
  }
}