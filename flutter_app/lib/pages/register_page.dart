// register_page.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/http_request.dart';
import 'package:flutter_app/widgets/my_widgets.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegistPageState createState() => _RegistPageState();
}

class _RegistPageState extends State<RegisterPage> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  TextEditingController _passwordController;
  FocusNode _usernameFocusNode, _passwordFocusNode, _passwordConfirmFocusNode;
  String _username = "";
  String _password = "";

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _usernameFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _passwordConfirmFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    final username = TextFormField(
      autofocus: true,
      focusNode: _usernameFocusNode,
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
      controller: _passwordController,
      focusNode: _passwordFocusNode,
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
      decoration: myInputDecoration(labelText: '密码', hintText: '请输入密码'),
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (value) {
        // 按回车键焦点移至下一个框
        _passwordFocusNode.unfocus();
        FocusScope.of(context).requestFocus(_passwordConfirmFocusNode);
      },
    );

    final passwordConfirm = TextFormField(
      focusNode: _passwordConfirmFocusNode,
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
      onFieldSubmitted: (value) {
        _onSubmit();
      },
    );

    final registerButton = FlatButton(
      onPressed: _onSubmit,
      child: Text('注册'),
      padding: EdgeInsets.fromLTRB(10, 12, 10, 12),
      colorBrightness: Brightness.dark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      color: Theme.of(context).primaryColor,
    );

    return Scaffold(
      appBar: myAppBar(title: Text('注册')),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 30, 10, 30),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20.0),
              username,
              SizedBox(height: 10.0),
              password,
              SizedBox(height: 10.0),
              passwordConfirm,
              SizedBox(height: 20.0),
              Row(
                children: [
                  Expanded(child: registerButton),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onSubmit() async {
    final form = _formKey.currentState;
    Map<String, dynamic> result;
    if (form.validate()) {
      form.save();
      // print("username:$_username  password:$_password");
      result = await HttpRequest.post(
        '/register',
        data: {'username': _username, 'password': _password},
      );
      if (result['code'] == 200) {
        Navigator.of(context).pop();
      } else {
        debugPrint(result['message']);
      }
    }
  }
}
