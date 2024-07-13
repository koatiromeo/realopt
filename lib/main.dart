import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';
import 'package:realopt/utils/functions.dart';
import 'dart:convert';
import 'package:realopt/constant/theme.dart';
import 'package:realopt/utils/route_name.dart';
import 'package:realopt/utils/routes.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

Future main() async
{

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await dotenv.load(fileName: ".env");
  await GetStorage.init();
  final GetStorage storage = GetStorage();

  if(storage.read("FirstAccess") != null)
  {
      if(storage.read("userSession") != null)
      {
        if(storage.read("userEmail") != null)
        {
          try
          {
            var dataBody = await fetchdata(
                "${dotenv.env['API_BASE_ADDRESS']}check_profile_avaible", "post",
                {"email": storage.read("userEmail")}, storage.read("userSession"));
            var reponseTo = jsonDecode(dataBody.toString());
            if (reponseTo["status"] == false && reponseTo["msg"] =="Profile Not existe")
            {
              storage.write("CanPass", 2);
            }
            else
            {
              if(reponseTo["status"] == true && reponseTo["msg"] =="Profile existe")
              {
                storage.write("CanPass", 3);
              }
              else
              {
                storage.write("CanPass", 1);
              }

            }

          }
          catch(e)
          {
            storage.write("CanPass", 1);
          }

        }
        else
        {
          storage.write("CanPass", 1);
        }

      }
      else
      {
        storage.write("CanPass", 1);
      }


  }
  else
  {

    storage.write("CanPass", 0);

  }

  runApp(const MyApp());
  FlutterNativeSplash.remove();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GetStorage _storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "REALOPT",
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      initialRoute: _storage.read("CanPass") == 2 ? RoutesName.agentProfileScreen  :
                    _storage.read("CanPass") == 3 ? RoutesName.homeScreen :
                    _storage.read("CanPass") == 0 ? ( kIsWeb ? RoutesName.landingPageScreen : (Platform.isAndroid || Platform.isIOS) ? RoutesName.onboarding_screen: RoutesName.startedScreen ) :
                    _storage.read("CanPass") == 1 ? ( kIsWeb ? RoutesName.landingPageScreen : (Platform.isAndroid || Platform.isIOS) ? RoutesName.startedScreen : RoutesName.startedScreen) :
                    RoutesName.errorScreen,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
