

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:tinylearn_client/functional/graphql/GraphQL.dart';
import 'package:tinylearn_client/functional/graphql_fragments/notificationFragment.dart';
import 'package:tinylearn_client/functional/graphql_fragments/postFragment.dart';
import 'package:tinylearn_client/functional/graphql_fragments/userFragment.dart';
import 'package:tinylearn_client/functional/networking/PostService/types/CursorInput.dart';
import 'package:tinylearn_client/functional/networking/UserService/types/GetVerifyCodeInput.dart';
import 'package:tinylearn_client/functional/networking/UserService/types/LoginOrRegisterInput.dart';
import 'package:tinylearn_client/functional/networking/UserService/types/NotificationsData.dart';
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
                hasSetUsername
                unreadNotificationsCount
                sum {
                  $userSumBasicFragment
                } 
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

  @override
  Future<NotificationsData> notifications(CursorInput input) async {
    return await this._graphQL.query(
      options: QueryOptions(
        documentNode: gql('''
        query Notifications(\$take: Int!, \$cursor: String) {
          notifications(input: { take: \$take, cursor: \$cursor }) {
            cursor
            items {
              $notificationBasicFragment
              
              followUserUser {
                $userBasicFragment
              }

              upPostUser {
                $userBasicFragment
              }
              upPostPost {
                $postBasicFragment
              }
              
              markPostUser {
                $userBasicFragment
              }
              markPostPost {
                $postBasicFragment
              }

            }
          }
        }
        '''),
        fetchPolicy: FetchPolicy.networkOnly,
        variables: input.toMap(),
      ),
      parse: (data) => NotificationsData.fromMap(data),
    );
  }

  @override
  Future<String> markAllNotificationsAsRead() async {
    return await this._graphQL.mutate(
      options: MutationOptions(
        documentNode: gql('''
          mutation {
            markAllNotificationsAsRead
          }
        '''),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
      parse: (data) => data['markAllNotificationsAsRead']
    );
  }
}