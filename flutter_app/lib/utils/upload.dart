// upload.dart
import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_app/utils/http_request.dart';

Future<String> pickImage(ImageSource source, {BuildContext context}) async {
  final _picker = ImagePicker();
  final PickedFile pickedFile = await _picker.getImage(source: source);
  final File file = File(pickedFile.path);

  if (file == null) return null;
  // We simply return the absolute path to selected file.
  try {
    String url = await uploadImageCallBack(file, context: context);
    print('Image uploaded and its url is $url');
    return url;
  } catch (error) {
    print('Upload image error $error');
  }
  return null;
}

Future<String> uploadImageCallBack(File file, {BuildContext context}) async {
  // return 'https://gitee.com/huyc2020/images/raw/master/img/3lg8x7-vy02f7-bkpojb-fslf0g.jpg';
  MultipartFile _file = MultipartFile.fromFileSync(file.path);
  Map<String, dynamic> result = await HttpRequest.post('/upload',
      formData: FormData.fromMap({'file': _file}));
  if (result['code'] == 200) {
    return result['data'][0].toString();
  } else {
    return 'https://pub.flutter-io.cn/static/img/pub-dev-logo-2x.png?hash=umitaheu8hl7gd3mineshk2koqfngugi';
  }
}
