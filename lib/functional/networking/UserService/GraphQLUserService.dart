

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:tinylearn_client/functional/graphql/GraphQL.dart';
import 'package:tinylearn_client/functional/graphql_fragments/userFragment.dart';
import 'package:tinylearn_client/functional/networking/UserService/types/GetVerifyCodeInput.dart';
import 'package:tinylearn_client/functional/networking/UserService/types/LoginOrRegisterInput.dart';
import 'UserService.dart';
import 'types/LoginOrRegisterData.dart';

class GraphQLUserService extends UserService {

  final GraphQL _graphQL;

  GraphQLUserService(this._graphQL);

  @override
  Future<LoginOrRegisterData> loginOrRegister(LoginOrRegisterInput input) async {
    return await this._graphQL.mutate(
      options: MutationOptions(
        documentNode: gql('''
          mutation LoginOrRegister(\$phone: String!, \$code: String!) {
            loginOrRegister(input: { phone: \$phone, code: \$code }) {
              token
              user {
                $userBasicFragment
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

  @override
  Future<String> getVerifyCode(GetVerifyCodeInput input) async {
    return await this._graphQL.mutate(
      options: MutationOptions(
        documentNode: gql(r'''
          mutation GetVerifyCode($phone: String!) {
            getVerifyCode(input: { phone: $phone })
          }
        '''),
        fetchPolicy: FetchPolicy.networkOnly,
        variables: input.toMap()
      ),
      parse: (data) => data['getVerifyCode']
    );
  }
}