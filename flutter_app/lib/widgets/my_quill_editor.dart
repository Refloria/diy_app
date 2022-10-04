// my_quill_editor.dart
import 'package:flutter/material.dart';
import 'package:flutter_quill/widgets/controller.dart';
import 'package:flutter_quill/widgets/default_styles.dart';
import 'package:flutter_quill/widgets/editor.dart';
import 'package:tuple/tuple.dart';

class MyQuillEditor extends StatelessWidget {
  final QuillController controller;
  final FocusNode focusNode;
  final bool readOnly;
  final bool scrollable;
  final String placeholder;
  final EdgeInsets padding;
  final ScrollController scrollController;
  const MyQuillEditor(
    this.controller, {
    Key key,
    this.focusNode,
    this.padding,
    this.placeholder,
    this.readOnly = false,
    this.scrollable = true,
    this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
    TextStyle baseStyle = defaultTextStyle.style.copyWith(
      fontSize: 16.0,
      color: Colors.black,
      height: 1.3,
    );
    // TextStyle baseStyle = TextStyle(
    //   fontSize: 16.0,
    //   color: Colors.black,
    //   height: 1.5,
    // );
    Tuple2<double, double> baseSpacing = Tuple2(8.0, 0);
    return QuillEditor(
      minHeight: 300,
      controller: controller,
      scrollController: scrollController ?? ScrollController(),
      scrollable: scrollable,
      focusNode: focusNode ?? FocusNode(),
      autoFocus: false,
      readOnly: readOnly,
      placeholder: placeholder ?? '',
      enableInteractiveSelection: true,
      expands: false,
      padding: padding ?? EdgeInsets.fromLTRB(10, 5, 10, 5),
      customStyles: DefaultStyles(
        paragraph: DefaultTextBlockStyle(
            baseStyle, baseSpacing, Tuple2(0.0, 0.0), null),
        placeHolder: DefaultTextBlockStyle(
            TextStyle(
              fontSize: 16.0,
              height: 1.5,
              color: Colors.grey[400],
            ),
            baseSpacing,
            Tuple2(0.0, 0.0),
            null),
        lists: DefaultTextBlockStyle(
            baseStyle, baseSpacing, Tuple2(0.0, 6.0), null),
        indent: DefaultTextBlockStyle(
            baseStyle, baseSpacing, Tuple2(0.0, 6.0), null),
        align: DefaultTextBlockStyle(
            baseStyle, Tuple2(0.0, 0.0), Tuple2(0.0, 0.0), null),
      ),
    );
  }
}
