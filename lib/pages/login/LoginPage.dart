
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tinylearn_client/app/AppNotifier.dart';
import 'package:tinylearn_client/app/Configuration.dart';
import 'package:tinylearn_client/functional/networking/UserService/UserService.dart';
import 'package:tinylearn_client/widgets/AccentButton.dart';

import 'LoginNotifier.dart';

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


class React<L extends Listenable, T> extends StatefulWidget {

  final L listenable;
  final T Function(L listenable) select;
  final bool Function(T previous, T current) areEqual;
  final ValueChanged<T> onTigger;
  final Widget child;

  const React({
    Key key, 
    @required this.listenable,
    this.areEqual,
    @required this.select,
    @required this.onTigger,
    @required this.child
  }) :
    assert(listenable != null),
    assert(select != null),
    assert(onTigger != null),
    assert(child != null),
    super(key: key);

  @override
  _ReactState<L, T> createState() => _ReactState<L, T>();
}

class _ReactState<L extends Listenable, T> extends State<React<L, T>> {

  T _value;
  VoidCallback _listener;

  @override
  void initState() {

    final _listenable = widget.listenable;

    _listener = () {
      final newValue = widget.select(_listenable);
      if (_value == null && newValue == null) {

      } else if (_value == null && newValue != null) {
        _value = newValue;
        widget.onTigger(newValue);
      } else if (_value != null && newValue == null) {
        _value = newValue;
      } else if (_value != null && newValue != null) {
        final areValuesEqual = widget.areEqual != null
          ? widget.areEqual(_value, newValue)
          : _value == newValue;
        if (!areValuesEqual) {
          _value = newValue;
          widget.onTigger(newValue);
        }
      }
    };
    
    _listenable.addListener(_listener);

    super.initState();
  }

  @override
  dispose() {
    widget.listenable.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}