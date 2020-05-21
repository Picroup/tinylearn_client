
import 'package:graphql_flutter/graphql_flutter.dart';

String errorMessage(Object error) {
  if (error is OperationException) {
    if (error.graphqlErrors.isNotEmpty) {
      return error.graphqlErrors
        .map((error) => error.message)
        .join("\n");
    }
  } 
  return '$error';
}