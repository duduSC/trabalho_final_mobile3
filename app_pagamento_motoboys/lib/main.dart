import 'package:app_pagamento_motoboys/pages/config.dart';
import 'package:app_pagamento_motoboys/pages/forms/usersForm.dart';
import 'package:app_pagamento_motoboys/pages/gerenciaTeles.dart';
import 'package:app_pagamento_motoboys/pages/home.dart';
import 'package:app_pagamento_motoboys/pages/login.dart';
import 'package:app_pagamento_motoboys/pages/motoboys.dart';
import 'package:app_pagamento_motoboys/pages/forms/motoboysForm.dart';
import 'package:app_pagamento_motoboys/pages/sobre.dart';
import 'package:app_pagamento_motoboys/provider/userProvider.dart';
import 'package:app_pagamento_motoboys/router.dart';
import 'package:app_pagamento_motoboys/services/motoboyService.dart';
import 'package:app_pagamento_motoboys/services/userService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//import 'pages/homeTabBarPage.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Userprovider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final userService = UserService();
    final motoboyService = MotoboyService();

    return MaterialApp(
      title: 'Meu app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      initialRoute: Routes.login,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case Routes.login:
            return MaterialPageRoute(
              settings: const RouteSettings(name: Routes.login),
              builder: (_) => const Login(),
            );
          case Routes.home:
            return MaterialPageRoute(
              settings: const RouteSettings(name: Routes.home),
              builder: (_) => const Home(),
            );
          case Routes.usersForm:
            return MaterialPageRoute(
              settings: const RouteSettings(name: Routes.usersForm),
              builder: (_) => Usersform(service: userService),
            );
          case Routes.motoboys:
            return MaterialPageRoute(
              settings: const RouteSettings(name: Routes.motoboys),
              builder: (_) => Motoboys(service: motoboyService),
            );
          case Routes.motoboyForm:
            return MaterialPageRoute(
              settings: const RouteSettings(name: Routes.motoboyForm),
              builder: (_) => Motoboysform(service: motoboyService),
            );
          case Routes.teles:
            return MaterialPageRoute(
              settings: const RouteSettings(name: Routes.teles),
              builder: (_) => GerenciamentoTelesPage(service: motoboyService),
            );
          case Routes.sobre:
            return MaterialPageRoute(
              settings: const RouteSettings(name: Routes.sobre),
              builder: (_) => Sobre(),
            );
            case Routes.config:
            return MaterialPageRoute(
              settings: const RouteSettings(name: Routes.sobre),
              builder: (_) => Config(),
            );
          default:
            return MaterialPageRoute(builder: (_) => const Login());
        }
      },
    );
  }
}
