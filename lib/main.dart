import 'package:dspython/screens/ForgotPasswordPage.dart';
import 'package:dspython/screens/device_sessions_page.dart';
import 'package:dspython/screens/home_page.dart';
import 'package:dspython/screens/login_page.dart';
import 'package:dspython/screens/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:dspython/screens/device_sessions_graphql.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter(); // Requis pour le cache GraphQL
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink('http://10.0.2.2:8000/graphql/');

    final ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(store: HiveStore()),
      ),
    );

    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        title: 'Flutter + Django',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: LoginPage(),
        routes: {
          '/home': (context) => HomePage(),
          '/forgot-password': (context) => ForgotPasswordPage(),
          '/login': (context) => LoginPage(),
          '/signup': (context) => SignUpPage(),
        //  '/counter': (context) => MyHomePage(title: 'Counter Page'),
          '/devices': (context) => const DeviceSessionsPage(),
          '/devices-graphql': (context) => const DeviceSessionsGraphQLPage(),

        },
      ),
    );
  }
}
