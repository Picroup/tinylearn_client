
import 'package:flutter/widgets.dart';

typedef Widget Build<T>(T placeholder);
typedef BuildMiddleware<T, R> = Build<R> Function(Build<T> build);

class Chain<T> {

  final Build<T> build;

  Chain(this.build);

  Chain<R> apply<R>(BuildMiddleware<T, R> middleware) {
    final newBuild = middleware(this.build);
    return Chain<R>(newBuild);
  }

  Chain<R> then<R>(T transform(R placeholder)) {
    return this.apply((source) => (placeholder) =>
      source(transform(placeholder))
    );
  } 

 Chain<Widget> child(T transform(Widget child)) {
   return this.then<Widget>(transform);
 } 
}
