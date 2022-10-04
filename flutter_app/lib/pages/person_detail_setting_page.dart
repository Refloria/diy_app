// person_detail_setting_page.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/http_request.dart';
import 'package:flutter_app/utils/upload.dart';
import 'package:flutter_app/widgets/my_widgets.dart';
import 'package:flutter_app/widgets/user_avatar.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonDetailSettingPage extends StatefulWidget {
  final int userId;

  PersonDetailSettingPage({Key key, this.userId}) : super(key: key);

  @override
  _PersonDetailSettingPageState createState() =>
      _PersonDetailSettingPageState();
}

class _PersonDetailSettingPageState extends State<PersonDetailSettingPage> {
  int _userId;
  String _userNickname;
  String _userPicture;
  String _userSex;
  String _userBirthday;
  String _userIntroduction;

  @override
  void initState() {
    super.initState();
    _userId = widget.userId;
    _loadDetail();
  }

  void _loadDetail() async {
    final Map<String, dynamic> result = await HttpRequest.post(
      '/getUserDetail',
      data: {'id': _userId},
    );
    setState(() {
      _userNickname = result['data']['nickname'];
      _userPicture = result['data']['picture'];
      _userSex = result['data']['sex'];
      _userBirthday = result['data']['birthday'];
      _userIntroduction = result['data']['introduction'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title: Text('编辑资料')),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          children: [
            PersonDetailSettingItem(
              title: Text('头像'),
              content: UserAvatar(
                radius: 25,
                picUrl: _userPicture,
              ),
              onTap: () {
                toDetailSettingPage(
                  context,
                  originalText: _userPicture,
                  settingType: UserDetailSettingType.PICTURE_SETTING,
                ).then((value) {
                  if (value != null) {
                    setState(() {
                      _userPicture = value;
                    });
                  }
                });
              },
            ),
            _divider(),
            PersonDetailSettingItem(
              title: Text('昵称'),
              content: Text(
                _userNickname ?? '编辑昵称',
                style: TextStyle(color: Colors.grey[400]),
              ),
              onTap: () {
                toDetailSettingPage(
                  context,
                  originalText: _userNickname,
                  settingType: UserDetailSettingType.NICKNAME_SETTING,
                ).then((value) {
                  if (value != null) {
                    setState(() {
                      _userNickname = value;
                    });
                  }
                });
              },
            ),
            _divider(),
            PersonDetailSettingItem(
              title: Text('密码'),
              content: Text(
                '修改密码',
                style: TextStyle(color: Colors.grey[400]),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => PasswordSettingPage(),
                  ),
                );
              },
            ),
            _divider(),
            PersonDetailSettingItem(
              title: Text('性别'),
              content: Text(
                _userSex ?? '选择性别',
                style: TextStyle(color: Colors.grey[400]),
              ),
              onTap: () {
                toDetailSettingPage(
                  context,
                  originalText: _userSex,
                  settingType: UserDetailSettingType.SEX_SETTING,
                ).then((value) {
                  if (value != null) {
                    setState(() {
                      _userSex = value;
                    });
                  }
                });
              },
            ),
            _divider(),
            PersonDetailSettingItem(
              title: Text('出生年月'),
              content: Text(
                _userBirthday ?? '选择生日',
                style: TextStyle(color: Colors.grey[400]),
              ),
              onTap: () {
                toDetailSettingPage(
                  context,
                  originalText: _userBirthday,
                  settingType: UserDetailSettingType.BIRTHDAY_SETTING,
                ).then((value) {
                  if (value != null) {
                    setState(() {
                      _userBirthday = value;
                    });
                  }
                });
              },
            ),
            _divider(),
            PersonDetailSettingItem(
              title: Text('个人简介'),
              content: Text(
                _userIntroduction ?? '这个人很懒，什么也没写',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.grey[400]),
              ),
              onTap: () {
                toDetailSettingPage(
                  context,
                  originalText: _userIntroduction,
                  settingType: UserDetailSettingType.INTRODUCTION_SETTING,
                ).then((value) {
                  if (value != null) {
                    setState(() {
                      _userIntroduction = value;
                    });
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  /// 分割线
  Widget _divider() {
    return Divider(height: 1, indent: 5, endIndent: 5);
  }

  /// 跳转至编辑页面
  Future<dynamic> toDetailSettingPage(context,
      {String originalText, UserDetailSettingType settingType}) async {
    return await Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => DetailSettingPage(
          originalText: originalText,
          settingType: settingType,
        ),
      ),
    );
  }
}

class PersonDetailSettingItem extends StatelessWidget {
  final Widget title;
  final Widget content;
  final GestureTapCallback onTap;

  PersonDetailSettingItem({Key key, this.title, this.content, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.fromLTRB(5, 12, 0, 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            title,
            Row(
              children: [
                Container(
                  constraints: BoxConstraints(maxWidth: 220),
                  child: content,
                  margin: EdgeInsets.only(right: 5, left: 5),
                ),
                Icon(Icons.keyboard_arrow_right, color: Colors.grey),
              ],
            )
          ],
        ),
      ),
    );
  }
}

/// 用户信息编辑的具体对象
enum UserDetailSettingType {
  /// 用户头像编辑
  PICTURE_SETTING,

  /// 用户昵称编辑
  NICKNAME_SETTING,

  /// 用户性别编辑
  SEX_SETTING,

  /// 用户生日编辑
  BIRTHDAY_SETTING,

  /// 用户个人介绍编辑
  INTRODUCTION_SETTING,
}

/// 具体的编辑页面
class DetailSettingPage extends StatefulWidget {
  /// 初始数据
  final String originalText;

  /// 要编辑的类别
  final UserDetailSettingType settingType;

  DetailSettingPage(
      {Key key,
      this.originalText,
      this.settingType = UserDetailSettingType.PICTURE_SETTING})
      : super(key: key);

  @override
  _DetailSettingPageState createState() => _DetailSettingPageState();
}

class _DetailSettingPageState extends State<DetailSettingPage> {
  var _userBirthday;
  var _controller;

  /// 编辑对象的变量名
  String _editingDataName;

  /// 编辑对象的值
  String _editingDataValue;

  @override
  void initState() {
    super.initState();
    _editingDataValue = widget.originalText; // 赋为初始值
  }

  @override
  Widget build(BuildContext context) {
    String appBarTitle = '修改';
    Widget bodyWidget;

    switch (widget.settingType) {
      // 头像
      case UserDetailSettingType.PICTURE_SETTING:
        appBarTitle += '头像';
        _editingDataName = 'picture';
        bodyWidget = Padding(
          padding: EdgeInsets.only(top: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UserAvatar(radius: 100, picUrl: _editingDataValue),
              SizedBox(height: 10),
              myFlatButton(
                text: '选择图片',
                onPressed: () async {
                  String url =
                      await pickImage(ImageSource.gallery, context: context);
                  setState(() {
                    _editingDataValue = url;
                  });
                },
              ),
            ],
          ),
        );
        break;

      // 昵称
      case UserDetailSettingType.NICKNAME_SETTING:
        appBarTitle += '昵称';
        _editingDataName = 'nickname';
        if (_controller == null)
          _controller = TextEditingController(text: _editingDataValue);
        bodyWidget = Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: TextField(
            controller: _controller,
            maxLength: 30,
            minLines: 1,
            maxLines: 2,
            decoration: InputDecoration(
              isCollapsed: true,
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
              hintText: '请输入昵称',
            ),
          ),
        );
        break;

      // 性别
      case UserDetailSettingType.SEX_SETTING:
        appBarTitle += '性别';
        _editingDataName = 'sex';
        bodyWidget = Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              value: '男',
              title: Text('男'),
              groupValue: _editingDataValue,
              onChanged: (value) {
                print(value.toString());
                setState(() {
                  _editingDataValue = value;
                });
              },
              activeColor: Theme.of(context).primaryColor,
              selected: _editingDataValue == '男',
            ),
            RadioListTile<String>(
              value: '女',
              title: Text('女'),
              groupValue: _editingDataValue,
              onChanged: (value) {
                print(value.toString());
                setState(() {
                  _editingDataValue = value;
                });
              },
              activeColor: Theme.of(context).primaryColor,
              selected: _editingDataValue == '女',
            ),
          ],
        );
        break;

      // 生日
      case UserDetailSettingType.BIRTHDAY_SETTING:
        appBarTitle += '生日';
        _editingDataName = 'birthday';
        DateTime today = DateTime.now();
        DateTime initDate = _editingDataValue == null
            ? today
            : DateTime.parse(_editingDataValue);
        bodyWidget = CalendarDatePicker(
          initialCalendarMode: DatePickerMode.day,
          initialDate: initDate,
          currentDate: initDate,
          firstDate: DateTime(1900, 1, 1),
          lastDate: today,
          onDateChanged: (dateTime) {
            _userBirthday = dateTime;
          },
        );
        break;

      // 简介
      case UserDetailSettingType.INTRODUCTION_SETTING:
        appBarTitle += '简介';
        _editingDataName = 'introduction';
        if (_controller == null)
          _controller = TextEditingController(text: _editingDataValue);
        bodyWidget = Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: TextField(
            controller: _controller,
            maxLength: 100,
            // keyboardType: TextInputType.multiline,
            // minLines: 1,
            minLines: 5,
            maxLines: 7,
            decoration: InputDecoration(
              isCollapsed: true,
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
              hintText: '请输入个人简介',
            ),
          ),
        );
        break;

      default:
        break;
    }

    return Scaffold(
      appBar: myAppBar(
        title: Text(appBarTitle),
        actions: [
          TextButton(
            onPressed: _onSubmit,
            child: Text('完成', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.all(10),
        child: bodyWidget,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  /// 提交
  void _onSubmit() async {
    final prefs = await SharedPreferences.getInstance();
    print(prefs.toString());
    var userId = prefs.getInt('user_id');
    switch (widget.settingType) {
      case UserDetailSettingType.NICKNAME_SETTING:
      case UserDetailSettingType.INTRODUCTION_SETTING:
        _editingDataValue = _controller.text; // 昵称和简介获取文本框中文本
        break;
      case UserDetailSettingType.BIRTHDAY_SETTING:
        if (_userBirthday != null) {
          // 生日将时间转为字符串
          var year = _userBirthday.year.toString();
          var month = _userBirthday.month.toString();
          var day = _userBirthday.day.toString();
          if (month.length < 2) month = '0' + month;
          if (day.length < 2) day = '0' + day;
          _editingDataValue = '$year-$month-$day';
        }
        break;
      default:
        break;
    }
    Map<String, dynamic> result = await HttpRequest.post(
      '/upgradeUserDetail',
      data: {'id': userId, _editingDataName: _editingDataValue},
    );
    if (result['code'] == 200) {
      Navigator.of(context).pop(_editingDataValue); // 回传新设置的值
    } else {
      EasyLoading.showError('修改失败');
    }
  }
}

/// 修改密码页面
class PasswordSettingPage extends StatefulWidget {
  @override
  _PasswordSettingPageState createState() => _PasswordSettingPageState();
}

class _PasswordSettingPageState extends State<PasswordSettingPage> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String _oldPassword = "";
  String _password = "";
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final oldPassword = TextFormField(
      autofocus: true,
      maxLines: 1,
      onSaved: (value) => this._oldPassword = value,
      validator: (value) {
        if (value.length <= 0) {
          return "旧密码不能为空";
        } else {
          return null;
        }
      },
      decoration: myInputDecoration(labelText: '旧密码', hintText: '请输入旧密码'),
    );

    final password = TextFormField(
      controller: _passwordController,
      maxLines: 1,
      obscureText: true,
      onSaved: (value) => this._password = value,
      validator: (value) {
        if (value.length <= 0) {
          return "密码不能为空";
        } else if (value.length < 6) {
          return "密码不能小于6个字符";
        } else if (value.length > 16) {
          return "密码不能大于16个字符";
        } else if (!RegExp(r"(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$")
            .hasMatch(value)) {
          return "密码须包含字母和数字";
        } else {
          return null;
        }
      },
      decoration: myInputDecoration(labelText: '新密码', hintText: '请输入新密码'),
    );

    final passwordConfirm = TextFormField(
      maxLines: 1,
      obscureText: true,
      validator: (value) {
        if (value.length <= 0) {
          return "确认密码不能为空";
        } else if (value.toString() != _passwordController.text.toString()) {
          return "两次输入密码不一致";
        } else {
          return null;
        }
      },
      decoration: myInputDecoration(labelText: '确认密码', hintText: '请再次输入密码'),
    );
    return Scaffold(
      appBar: myAppBar(
        title: Text('修改密码'),
        actions: [
          TextButton(
            onPressed: _onSubmit,
            child: Text('完成', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20.0),
              oldPassword,
              SizedBox(height: 15.0),
              password,
              SizedBox(height: 15.0),
              passwordConfirm,
            ],
          ),
        ),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  /// 提交
  void _onSubmit() async {
    final form = _formKey.currentState;
    Map<String, dynamic> result;
    if (form.validate()) {
      form.save();
      // print("username:$_username  password:$_password");
      result = await HttpRequest.post(
        '/upgradeUserPassword',
        data: {'oldPassword': _oldPassword, 'password': _password},
      );
      if (result['code'] == 200) {
        Navigator.of(context).pop();
      } else {
        EasyLoading.showToast(result['message']);
      }
    }
  }
}
