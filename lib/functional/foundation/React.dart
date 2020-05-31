
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

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