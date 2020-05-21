
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tinylearn_client/app/Configuration.dart';
import 'package:tinylearn_client/widgets/AccentButton.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  // BuildContext _scaffoldContext;
  TextEditingController _codeEditingController;
  FocusNode _codeFocusNode;

  @override
  void initState() {
    _codeEditingController = TextEditingController(text: '');
    _codeFocusNode = FocusNode();
    super.initState();
  }

  void _onGetCodePressed(BuildContext context) async {
    print('_onGetCodePressed');

    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('验证码发送成功！'),
    ));

    _codeEditingController.clear();
    _codeFocusNode.requestFocus();

    final Configuration configuration = context.read();
    final LoginViewModel loginViewModel = context.read();
    final totalSeconds = configuration.codeCountDownSeconds;
    loginViewModel.setRemainSeconds(totalSeconds);
    final counts = Stream.periodic(Duration(seconds: 1), (index) => index + 1).take(totalSeconds);
    await for (var passed in counts) {
      loginViewModel.setRemainSeconds(totalSeconds - passed);
    }
  }

  void _onLoginPressed(BuildContext context) async {
    print('_onLoginPressed');
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginViewModel>(
      create: (_) => LoginViewModel(),
      child: Scaffold(
        body: _buildBody(),
      ),
    );
  }


  Widget _buildBody() {
   return Builder(builder: (context) {
      final LoginViewModel loginViewModel = context.watch();

      return Center(
        child: SizedBox(
          width: 250,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 196),
              _phoneTextField(onChanged: loginViewModel.setPhone),
              _codeWidget(
                getCodeButtonText: loginViewModel.getCodeText,
                onCodeChanged: loginViewModel.setCode,
                onGetCodePressed: !loginViewModel.isGetCodeEnable
                  ? null
                  : () => this._onGetCodePressed(context)
              ),
              SizedBox(height: 24),
              _loginButton(
                isLoading: loginViewModel.isLoading, 
                onPressed: !loginViewModel.isLoginEnable
                  ? null
                  : () => this._onLoginPressed(context)
              ),
            ],
          )
        ),
      );
   });
  }

  Widget _phoneTextField({ValueChanged<String> onChanged}) {
    return TextField(
      autofocus: true,
      maxLength: 11,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        icon: Icon(Icons.phone_android),
        labelText: '手机',
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
      child: Text('登录'),
      onPressed: onPressed,
    );
  }

}

class LoginViewModel extends ChangeNotifier {
  
  // states
  String phone = '';
  String code = '';
  bool isLoading = false;

  bool isGettingCode = false;
  int remainSeconds = 0;

  bool get isLoginEnable => phone.length >= 11
      && code.length >= 6
      && !isLoading;

  bool get isCountingDown => remainSeconds > 0;

  bool get isGetCodeEnable => phone.length >= 11
    && !isCountingDown
    && !isGettingCode;

  String get getCodeText => remainSeconds == 0
    ? '获取验证码'
    : '重新获取($remainSeconds)';

  void setIsGettingCode(bool value) {
    isGettingCode = value;
    notifyListeners();
  }

  void setRemainSeconds(int value) {
    remainSeconds = value;
    notifyListeners();
  }
  
  void setPhone(String value) {
    phone = value;
    notifyListeners();
  }
  
  void setCode(String value) {
    code = value;
    notifyListeners();
  }

  void setIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}