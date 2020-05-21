import 'package:flutter/material.dart';

class AccentButton extends StatelessWidget {
  
  const AccentButton({
    Key key,
    @required this.child, 
    @required this.onPressed,
  }) : super(key: key);

  final Widget child;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: child,
      color: Theme.of(context).accentColor,
      textColor: Colors.white,
      disabledColor: Colors.grey[300],
      onPressed: onPressed,
    );
  }
}
