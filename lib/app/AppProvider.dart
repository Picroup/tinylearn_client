
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tinylearn_client/app/AppNotifier.dart';
import 'package:tinylearn_client/app/Configuration.dart';
import 'package:tinylearn_client/functional/graphql/ModelRequest.dart';
import 'package:tinylearn_client/functional/graphql/createModelRequest.dart';
import 'package:tinylearn_client/functional/networking/PostService/GraphQLPostService.dart';
import 'package:tinylearn_client/functional/networking/PostService/PostService.dart';
import 'package:tinylearn_client/functional/networking/UserService/GraphQLUserService.dart';
import 'package:tinylearn_client/functional/networking/UserService/UserService.dart';
import 'package:tinylearn_client/functional/storage/MiniStorage.dart';

class AppProvider extends StatelessWidget {
   final Widget child;

  const AppProvider({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Configuration>.value(value: configuration),
        Provider<MiniStorage>(create: (context) => MiniStorage()),
        Provider<ModelRequest>(
          create: (context) {
            final Configuration config = context.read();
            final MiniStorage miniStorage = context.read();
            return createModelRequest(
              uri: config.uri,
              getToken: () => miniStorage.token,
            );
          },
        ),
        Provider<PostService>(
          create: (context) {
            final ModelRequest modelRequest = context.read();
            return GraphQLPostService(modelRequest);
          }
        ),
        Provider<UserService>(
          create: (context) {
            final ModelRequest modelRequest = context.read();
            return GraphQLUserService(modelRequest);
          }
        ),
        ChangeNotifierProvider<AppNotifier>(
          create: (context) {
            final MiniStorage storage = context.read();
            final AppNotifier appNotifier = AppNotifier(
              getSessionInfo: ()  => storage.sessionInfo,
              setSessionInfo: (value) => storage.setSessionInfo(value),
            );
            return appNotifier;
          }
        ),
      ],
      child: child,
    );
  }
}