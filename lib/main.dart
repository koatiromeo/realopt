import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';
import 'package:realopt/utils/functions.dart';
import 'dart:convert';
import 'package:realopt/constants/theme.dart';
import 'package:realopt/utils/route_name.dart';
import 'package:realopt/utils/routes.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

Future main() async
{

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await dotenv.load(fileName: ".env");
  await GetStorage.init();
  final GetStorage storage = GetStorage();
  const facebookAppId = "452619727535330";
  if (kIsWeb) {
    await FacebookAuth.i.webAndDesktopInitialize(
        appId: facebookAppId, cookie: true, xfbml: true, version: "v14.0");
  }
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
                    _storage.read("CanPass") == 0 ? ( kIsWeb ? RoutesName.landingScreen : (Platform.isAndroid || Platform.isIOS) ? RoutesName.onboardingScreen: RoutesName.startedScreen ) :
                    _storage.read("CanPass") == 1 ? ( kIsWeb ? RoutesName.landingScreen : (Platform.isAndroid || Platform.isIOS) ? RoutesName.startedScreen : RoutesName.startedScreen) :
                    RoutesName.errorScreen,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
