import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

PreferredSize myAppBar(
    {Widget title,
    List<Widget> actions,
    double height = 50.0,
    double titleSpacing}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(height), // here the desired height
    child: AppBar(
      title: title,
      actions: actions,
      titleSpacing: titleSpacing,
    ),
  );
}

Widget myFlatButton(
    {@required void Function() onPressed, String text = '', Padding padding}) {
  return CupertinoButton(
    onPressed: onPressed,
    child: Text(text,
        style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.normal)),
    padding: padding ?? EdgeInsets.fromLTRB(10, 0, 10, 0),
    color: Colors.blue[400],
    minSize: 30,
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
    pressedOpacity: 0.8,
  );
}

InputDecoration myInputDecoration({String labelText, String hintText}) {
  return InputDecoration(
    labelText: labelText,
    hintText: hintText,
    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25.0),
      borderSide: BorderSide(
        width: 1.5,
        color: Colors.blue[400],
      ),
    ),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: BorderSide(color: Colors.red[700])),
    focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: BorderSide(width: 1.5, color: Colors.red[700])),
  );
}

Widget myListEnd({String text}) {
  return Row(
    children: [
      Expanded(
        child: Text(
          text ?? '没有了~',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey[400], height: 2.0),
        ),
      ),
    ],
  );
}

void myDialog(BuildContext context, {String content, VoidCallback accept}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('提示'),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            child: Text('取消'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('确认'),
            onPressed: accept,
          ),
        ],
      );
    },
  );
}

// void showSnackBar(BuildContext context, {String content}) {
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: Text(content ?? ''),
//       margin: EdgeInsets.fromLTRB(40, 10, 40, 20),
//       behavior: SnackBarBehavior.floating,
//       elevation: 0,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//       backgroundColor: Colors.black87,
//       duration: Duration(seconds: 2),
//     ),
//   );
// }
