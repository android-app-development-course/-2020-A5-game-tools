import 'package:flutter/material.dart';

class LoginRoute extends StatefulWidget {
  @override
  _LoginRouteState createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var formItems = [
      ...[
        TextFormField(
          controller: usernameController,
          decoration: InputDecoration(
            filled: true,
            labelText: '电子邮箱 / 手机号',
          ),
        ),
        TextFormField(
          controller: passwordController,
          decoration: InputDecoration(
            filled: true,
            labelText: '密码',
          ),
          obscureText: true,
        ),
        FlatButton(
          child: Text('确定'),
          onPressed: () {
            /*if (usernameController.value.text == "" ||
                passwordController.value.text == "")
              _showDialog(context, '请输入用户名或密码！');
            else*/
            Navigator.pop(context);
          },
        ),
      ].expand(
        (widget) => [
          widget,
          SizedBox(
            height: 24,
          )
        ],
      )
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('登录'),
      ),
      body: Form(
        child: Scrollbar(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              children: formItems,
            ),
          ),
        ),
      ),
    );
  }

  void _showDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      child: AlertDialog(
        title: Text(message),
        actions: [
          FlatButton(
            child: Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
