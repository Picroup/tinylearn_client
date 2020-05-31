
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tinylearn_client/app/AppNotifier.dart';
import 'package:tinylearn_client/app/Configuration.dart';
import 'package:tinylearn_client/functional/foundation/React.dart';
import 'package:tinylearn_client/functional/networking/UserService/UserService.dart';
import 'package:tinylearn_client/widgets/AccentButton.dart';

import 'LoginNotifier.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController _codeEditingController;
  FocusNode _codeFocusNode;

  @override
  void initState() {
    _codeEditingController = TextEditingController(text: '');
    _codeFocusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginNotifier>(
      create: (context) => LoginNotifier(
        appNotifier: context.read<AppNotifier>(),
        userService: context.read<UserService>(),
        codeCountDownSeconds: context.read<Configuration>().codeCountDownSeconds
      ),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: _buildBody(),
      ),
    );
  }
  

  Widget _buildBody() {
   return Builder(builder: (context) {
      final LoginNotifier loginNotifier = context.watch();
      
      return React(
        listenable: loginNotifier,
        select: (LoginNotifier listenable) => listenable.getCodeSuccessVersion,
        onTigger: (value) {
          _codeEditingController.clear();
          _codeFocusNode.requestFocus();
        },
        child: React(
          listenable: loginNotifier,
          select: (LoginNotifier listenable) => listenable.loginSuccessVersion,
          onTigger: (value) async {
            await Future.delayed(Duration(seconds: 2));
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
          child: React(
            listenable: loginNotifier,
            select: (LoginNotifier listenable) => listenable.message,
            areEqual: (previous, current) => identical(previous, current),
            onTigger: (message) => Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text(message))),
            child: Container(
              child: Center(
                child: SizedBox(
                  width: 250,
                  child: _buildListView(loginNotifier)
                ),
              ),
            ),
          ),
        ),
      );
   });
  }

  ListView _buildListView(LoginNotifier loginNotifier) {
    return ListView(
      children: <Widget>[
        SizedBox(height: 128),
        _phoneTextField(onChanged: loginNotifier.setPhone),
        _codeWidget(
          getCodeButtonText: loginNotifier.getCodeText,
          onCodeChanged: loginNotifier.setCode,
          onGetCodePressed: !loginNotifier.isGetCodeEnable
            ? null
            : loginNotifier.onTriggerGetCode
        ),
        SizedBox(height: 24),
        _loginButton(
          isLoading: loginNotifier.isLoading, 
          onPressed: !loginNotifier.isLoginEnable
            ? null
            : loginNotifier.onTiggerLogin
        ),
      ],
    );
  }

  Widget _phoneTextField({ValueChanged<String> onChanged}) {
    return TextField(
      autofocus: true,
      maxLength: 11,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        icon: Icon(Icons.phone_android),
        labelText: '手机号',
        border: InputBorder.none,
        counterText: '',
      ),
      onChanged: onChanged,
    );
  }

  Widget _codeWidget({
    ValueChanged<String> onCodeChanged,
    VoidCallback onGetCodePressed,
    String getCodeButtonText, 
  }) {
    return Row(
      children: <Widget>[
        Expanded(
          child: _codeTextField(onChanged: onCodeChanged),
        ),
        FlatButton(
          child: Text(getCodeButtonText),
          textColor: Theme.of(context).primaryColor,
          onPressed: onGetCodePressed,
        )
      ],
    );
  }

  Widget _codeTextField({ValueChanged<String> onChanged}) {
    return TextField(
      controller: this._codeEditingController,
      focusNode: this._codeFocusNode,
      keyboardType: TextInputType.number,
      maxLength: 6,
      decoration: InputDecoration(
        icon: Icon(Icons.filter_1),
        labelText: '验证码',
        border: InputBorder.none,
        counterText: '',
      ),
      onChanged:  onChanged,
      obscureText: false,
    );
  }

  Widget _loginButton({bool isLoading, VoidCallback onPressed}) {
    if (isLoading) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            child: CircularProgressIndicator(strokeWidth: 2,),
            width: 24,
            height: 24,
          )
        ],
      );
    }
    return AccentButton(
      child: Text('登录或注册'),
      onPressed: onPressed,
    );
  }

}

