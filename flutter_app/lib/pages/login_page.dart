// login_page.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/http_request.dart';
import 'package:flutter_app/utils/navigator.dart';
import 'package:flutter_app/widgets/my_widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  TextEditingController _usernameController, _passwordController;
  FocusNode _usernameFocusNode, _passwordFocusNode;
  String _username = "";
  String _password = "";

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _usernameController = TextEditingController();
    _usernameFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _loadUsername();
  }

  /// 加载之前使用的用户名
  void _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('user_name');
    if (username != null) {
      setState(() {
        _usernameController.text = username;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final username = TextFormField(
      focusNode: _usernameFocusNode,
      controller: _usernameController,
      maxLines: 1,
      onSaved: (value) => this._username = value,
      validator: (value) {
        if (value.length <= 0) {
          return "用户名不能为空";
        } else {
          return null;
        }
      },
      decoration: myInputDecoration(labelText: '用户名', hintText: '请输入用户名'),
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (value) {
        // 按回车键焦点移至下一个框
        _usernameFocusNode.unfocus();
        FocusScope.of(context).requestFocus(_passwordFocusNode);
      },
    );

    final password = TextFormField(
      focusNode: _passwordFocusNode,
      controller: _passwordController,
      maxLines: 1,
      obscureText: true,
      onSaved: (value) => this._password = value,
      validator: (value) {
        if (value.length <= 0) {
          return "密码不能为空";
        } else {
          return null;
        }
      },
      decoration: myInputDecoration(labelText: '密码', hintText: '请输入密码'),
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (value) {
        _onSubmit();
      },
    );

    final loginButton = FlatButton(
      onPressed: _onSubmit,
      child: Text('登录'),
      padding: EdgeInsets.fromLTRB(10, 12, 10, 12),
      colorBrightness: Brightness.dark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      color: Theme.of(context).primaryColor,
    );

    final registerButton = OutlineButton(
      onPressed: () {
        MyNavigator.toRegisterPage(context);
      },
      child: Text('注册'),
      padding: EdgeInsets.fromLTRB(10, 11, 10, 11),
      borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      textColor: Theme.of(context).primaryColor,
    );

    return Scaffold(
      appBar: myAppBar(title: Text('登录')),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 30, 10, 30),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20.0),
              username,
              SizedBox(height: 8.0),
              password,
              SizedBox(height: 20.0),
              Row(
                children: [
                  Expanded(child: registerButton),
                  SizedBox(width: 15),
                  Expanded(child: loginButton),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onSubmit() async {
    _usernameFocusNode.unfocus();
    _passwordFocusNode.unfocus();
    final form = _formKey.currentState;
    Map<String, dynamic> result;
    if (form.validate()) {
      form.save();
      result = await HttpRequest.post(
        '/login',
        data: {'username': _username, 'password': _password},
      );
      if (result['code'] == 200) {
        bool loginSuccess = false;
        Map<String, dynamic> data = result['data'];
        print(data['authorities'].toString());
        for (Map<String, dynamic> authority in data['authorities']) {
          if (authority['authority'] == 'user') {
            loginSuccess = true;
            break;
          }
        }
        if (loginSuccess) {
          final prefs = await SharedPreferences.getInstance();
          final setTokenResult = await prefs.setString('token', data['token']);
          await prefs.setInt('user_id', data['userId']);
          await prefs.setString('user_name', data['username']);
          if (setTokenResult) {
            debugPrint('登录成功');
            MyNavigator.toRootPage(context);
          } else {
            EasyLoading.showToast('error, 保存登录token失败');
          }
        } else {
          EasyLoading.showError('登录失败，没有权限');
          setState(() {
            _passwordController.clear();
          });
        }
      } else {
        EasyLoading.showToast('登录失败');
        setState(() {
          _passwordController.clear();
        });
      }
    }
  }
}
