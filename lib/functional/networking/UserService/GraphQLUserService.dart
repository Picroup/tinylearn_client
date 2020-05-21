

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:tinylearn_client/functional/graphql/ModelRequest.dart';
import 'package:tinylearn_client/models/LoginOrRegisterData.dart';
import 'package:tinylearn_client/functional/networking/UserService/types/LoginOrRegisterInput.dart';
import 'UserService.dart';

class GraphQLUserService extends UserService {

  final ModelRequest _modelRequest;

  GraphQLUserService(this._modelRequest);

  @override
  Future<LoginOrRegisterData> loginOrRegister(LoginOrRegisterInput input) async {
    return await this._modelRequest.mutate(
      options: MutationOptions(
        documentNode: gql(r'''
          mutation LoginOrRegister($phone: String!, $code: String!) {
            loginOrRegister(phone: $phone, code: $code) {
              token
              user {
                id
                username
                created
              }
            }
          }
        '''),
        fetchPolicy: FetchPolicy.networkOnly,
        variables: input.toMap()
      ),
      parse: (data) => LoginOrRegisterData.fromMap(data)
    );
  }
  
}