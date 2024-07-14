import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:realopt/utils/route_name.dart';
import 'package:realopt/utils/responsive.dart';
import 'package:realopt/utils/functions.dart';
import 'package:realopt/constants/colors.dart';
import 'package:realopt/constants/icons.dart';
import 'package:realopt/constants/styles.dart';
import 'package:realopt/utils/responsive_widget.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

class LoginScreen extends StatefulWidget {


  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isObscureText = true;

  bool _submittedEmail = false;
  bool _submittedPassword = false;

  String _errorEmailText = "";
  String _errorPasswordText = "";


  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();


  String emailValue = "";
  String passwordValue = "";

  String _localValue = "";

  final GetStorage _storage = GetStorage();
  late bool statusLogin = false;
  late String haveToPass = "1";

  Map<String,dynamic>? _userData;
  AccessToken? _accessToken;

  Future<void> _loginWithGoogle() async
  {
    await _submit();
  }


  Future<void> _loginWithFacebook() async {



    final LoginResult result = await FacebookAuth.instance.login(permissions: ['public_profile', 'email']);

    print(result.status);

    if(result.status == LoginStatus.success)
    {

        _accessToken = result.accessToken;
        _userData = await FacebookAuth.instance.getUserData();



        final email = _userData!["email"];
        final userUsername = _userData!["name"];
        final firstName = _userData!["firstname"];
        final lastName = _userData!["lastname"];
        final id = _userData!["id"];

        final imageUrl = "";
        if (email != null)
        {

          var dataBody = await fetchdata(
              "${dotenv.env['API_BASE_ADDRESS']}check_user", "post",
              {"email": email}, "");
          var response = jsonDecode(dataBody.toString());

          if (response["status"] == true)
          {

            _storage.write("user_email", email);
            _storage.write("user_username", userUsername);
            _storage.write("user_firstname", firstName);
            _storage.write("user_lastname", lastName);

            if(response["msg"] == "User Exist")
            {

              var dataBody = await fetchdata(
                  "${dotenv.env['API_BASE_ADDRESS']}login_social_media", "post",
                  {"email": email, "id": id, "accessToken": _accessToken!.tokenString, "username": userUsername}, "");
              var response = jsonDecode(dataBody.toString());

              if (response["status"] == false)
              {
                setState(() {
                  _localValue =
                  "Connectivity problem. Check you are internet connection and try again later.";
                });
              }
              else
              {

                _storage.write("userSession", response["token"]);
                _storage.write("userEmail", email);

                var dataBody = await fetchdata(
                    "${dotenv.env['API_BASE_ADDRESS']}check_profile_available", "post",
                    {"email": email}, response["token"]);
                var responseTo = jsonDecode(dataBody.toString());

                if (responseTo["status"] == false)
                {
                  XFile? imageFile;
                  try
                  {
                    final Directory tempDir = await getTemporaryDirectory();
                    final String tempPath = tempDir.path;

                    final http.Response response = await http.get(Uri.parse(imageUrl!));

                    final String fileName = path.basename(imageUrl);
                    final File file = File('$tempPath/$fileName');

                    await file.writeAsBytes(response.bodyBytes);

                    imageFile = XFile(file.path);

                    imageFile == null ?  _storage.write("user_avatar", "noImage") : _storage.write("user_avatar", base64Encode(imageFile?.readAsBytes() as List<int>));

                  }
                  catch (e)
                  {
                    setState(() {
                      _localValue =
                      "Connectivity problem. Check you are internet connection and try again later.";
                    });
                  }

                  Navigator.pushNamed(context, RoutesName.completeProfileScreen);
                }
                else
                {
                  var dataBody = await fetchdata(
                      "${dotenv.env['API_BASE_ADDRESS']}get_user_profile", "post",
                      {"email": email}, _storage.read("userSession"));
                  var responseTo = jsonDecode(dataBody.toString());

                  if (responseTo["status"])
                  {
                    Navigator.pushNamed(context, RoutesName.dashboardScreen);
                  }
                  else
                  {
                    setState(() {
                      _localValue =
                      "Connectivity problem. Check you are internet connection and try again later.";
                    });
                  }

                }

              }

            }
            else
            {

              if(response["msg"] == "User Not Exist")
              {
                  XFile? imageFile;

                  try
                  {
                      final Directory tempDir = await getTemporaryDirectory();
                      final String tempPath = tempDir.path;

                      final http.Response response = await http.get(Uri.parse(imageUrl!));

                      final String fileName = path.basename(imageUrl);
                      final File file = File('$tempPath/$fileName');

                      await file.writeAsBytes(response.bodyBytes);

                      imageFile = XFile(file.path);

                      imageFile == null ?  _storage.write("user_avatar", "noImage") : _storage.write("user_avatar", base64Encode(imageFile?.readAsBytes() as List<int>));

                      var signUpSocialMediaDataBody = await fetchdata(
                          "${dotenv.env['API_BASE_ADDRESS']}sign_up_social_media", "post",
                          {"email": email}, "");

                      var signUpSocialMediaDataResponse = jsonDecode(signUpSocialMediaDataBody.toString());

                      if(signUpSocialMediaDataResponse["status"] == false)
                      {
                        setState(() {
                          _localValue =
                          "Connectivity problem. Check you are internet connection and try again later.";
                        });
                      }
                      else
                      {
                          var dataBody = await fetchdata(
                              "${dotenv.env['API_BASE_ADDRESS']}login_social_media", "post",
                              {"email": email, "id": id, "accessToken": _accessToken!.tokenString, "username": userUsername}, "");

                          var responseTo = jsonDecode(dataBody.toString());

                          if (responseTo["status"] == false)
                          {
                            setState(() {
                              _localValue =
                              "Connectivity problem. Check you are internet connection and try again later.";
                            });
                          }
                          else
                          {

                            _storage.write("userSession", responseTo["token"]);
                            _storage.write("userEmail", email);

                            var dataBody = await fetchdata(
                                "${dotenv.env['API_BASE_ADDRESS']}check_profile_available", "post",
                                {"email": email}, responseTo["token"]);
                            var responseToDetail = jsonDecode(dataBody.toString());

                            if (responseToDetail["status"] == false)
                            {
                              XFile? imageFile;
                              try
                              {
                                final Directory tempDir = await getTemporaryDirectory();
                                final String tempPath = tempDir.path;

                                final http.Response response = await http.get(Uri.parse(imageUrl!));

                                final String fileName = path.basename(imageUrl);
                                final File file = File('$tempPath/$fileName');

                                await file.writeAsBytes(response.bodyBytes);

                                imageFile = XFile(file.path);

                                imageFile == null ?  _storage.write("user_avatar", "noImage") : _storage.write("user_avatar", base64Encode(imageFile?.readAsBytes() as List<int>));

                              }
                              catch (e)
                              {
                                setState(() {
                                  _localValue =
                                  "Connectivity problem. Check you are internet connection and try again later.";
                                });
                              }

                              Navigator.pushNamed(context, RoutesName.completeProfileScreen);
                            }
                            else
                            {
                              var dataBody = await fetchdata(
                                  "${dotenv.env['API_BASE_ADDRESS']}get_user_profile", "post",
                                  {"email": email}, _storage.read("userSession"));
                              var responseTo = jsonDecode(dataBody.toString());

                              if (responseTo["status"])
                              {
                                Navigator.pushNamed(context, RoutesName.dashboardScreen);
                              }
                              else
                              {
                                setState(() {
                                  _localValue =
                                  "Connectivity problem. Check you are internet connection and try again later.";
                                });
                              }

                            }

                          }
                      }

                  }
                  catch (e)
                  {
                    setState(() {
                      _localValue =
                      "Connectivity problem. Check you are internet connection and try again later.";
                    });
                  }


              }
              else
              {
                setState(() {
                  _localValue =
                  "Connectivity problem. Check you are internet connection and try again later.";
                });

              }

            }

          }
          else
          {
              setState(() {
                _localValue =
                "Connectivity problem. Check you are internet connection and try again later.";
              });
          }



        }
        else
        {
          setState(() {
            _localValue =
            "Connectivity problem. Check you are internet connection and try again later.";
          });
        }

    }
    else
    {
      setState(() {
        _localValue = "Connectivity problem. Check you are internet connection and try again later.";
      });
    }

  }


  Future<void> _submit() async {
    setState(() {
      _submittedEmail = false;
      _submittedPassword = false;
    });

    if (emailValue == null || emailValue.isEmpty) {
      setState(() {
        _errorEmailText = 'Can\'t be empty';
        _submittedEmail = true;
      });
    }
    else {
      const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
          r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
          r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
          r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
          r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
          r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
          r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
      final regex = RegExp(pattern);
      if (!regex.hasMatch(emailValue)) {
        setState(() {
          _errorEmailText = 'Enter a valid email address';
          _submittedEmail = true;
        });
      }
    }

    if (passwordValue == null || passwordValue.isEmpty) {
      setState(() {
        _errorPasswordText = 'Can\'t be empty';
        _submittedPassword = true;
      });
    }
    else {
      // Check length
      if (passwordValue.length < 8) {
        setState(() {
          _errorPasswordText =
          'At least 8 characters(digit,lowercase and uppercase letter and special char).';
          _submittedPassword = true;
        });
      }

      // Check for uppercase letters
      if (!RegExp(r'[A-Z]').hasMatch(passwordValue)) {
        setState(() {
          _errorPasswordText =
          'At least 8 characters(digit,lowercase and uppercase letter and special char).';
          _submittedPassword = true;
        });
      }

      // Check for lowercase letters
      if (!RegExp(r'[a-z]').hasMatch(passwordValue)) {
        setState(() {
          _errorPasswordText =
          'At least 8 characters(digit,lowercase and uppercase letter and special char).';
          _submittedPassword = true;
        });
      }

      // Check for digits
      if (!RegExp(r'[0-9]').hasMatch(passwordValue)) {
        setState(() {
          _errorPasswordText =
          'At least 8 characters(digit,lowercase and uppercase letter and special char).';
          _submittedPassword = true;
        });
      }

      // Check for special characters
      if (!RegExp(r'[!@#$%^&*(),.?\":{}|<>]').hasMatch(passwordValue)) {
        setState(() {
          _errorPasswordText =
          'At least 8 characters(digit,lowercase and uppercase letter and special char).';
          _submittedPassword = true;
        });
      }
    }


    if (!_submittedEmail && !_submittedPassword) {
      var dataBody = await fetchdata(
          "${dotenv.env['API_BASE_ADDRESS']}login", "post",
          {"email": emailValue, "password": passwordValue}, "");
      var response = jsonDecode(dataBody.toString());

      setState(() {
        if (response["status"] == false) {
          if (response["msg"] == "Not Activate") {
            statusLogin = false;
            setState(() {
              _localValue = "";
            });
            haveToPass = "2";
          }
          else {
            setState(() {
              _localValue = "Incorrect email or password.";
            });
            haveToPass = "3";
          }
        }
        else {
          statusLogin = true;
          haveToPass = "4";
        }
      });
      if (haveToPass == "2") {
        var dataBody = await fetchdata(
            "${dotenv.env['API_BASE_ADDRESS']}request_otp", "post",
            {"email": emailValue}, "");
        var response = jsonDecode(dataBody.toString());

        if (response["status"] == false) {
          setState(() {
            _localValue =
            "Connectivity problem. Check you are internet connection and try again later.";
          });
        }
        else {
          Navigator.pushNamed(context, RoutesName.emailVerifyScreen);
        }
      }

      if (haveToPass == "4") {
        _storage.write("userSession", response["token"]);
        _storage.write("userEmail", emailValue);

        var dataBody = await fetchdata(
            "${dotenv.env['API_BASE_ADDRESS']}check_profile_avaible", "post",
            {"email": emailValue}, response["token"]);
        var responseTo = jsonDecode(dataBody.toString());

        if (responseTo["status"] == false) {
          Navigator.pushNamed(context, RoutesName.completeProfileScreen);
        }
        else {
          var dataBody = await fetchdata(
              "${dotenv.env['API_BASE_ADDRESS']}get_user_profile", "post",
              {"email": emailValue}, _storage.read("userSession"));
          var responseTo = jsonDecode(dataBody.toString());

          if (responseTo["status"]) {
            Navigator.pushNamed(context, RoutesName.dashboardScreen);
          }
          else {
            setState(() {
              _localValue = "Incorrect email or password.";
            });
          }
        }
      }
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isObscureText = true;
    emailValue = "";
    passwordValue = "";
    _errorEmailText = "";
    passwordValue = "";
    _errorPasswordText = "";
    _submittedEmail = false;
    _submittedPassword = false;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery
        .of(context)
        .size
        .height;
    double width = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
      backgroundColor: AppColors.backColor,
      body: SizedBox(
        height: height,
        width: width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            !Responsive.isDesktop(context) ? const SizedBox() : Expanded(
              child: Container(
                height: height,
                color: AppColors.blueDarkColor,
                child: Center(
                  child: Text(
                    'Real Estate Optimize',
                    style: ralewayStyle.copyWith(
                      fontSize: 48.0,
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: height,
                margin: EdgeInsets.symmetric(
                    horizontal: ResponsiveWidget.isSmallScreen(context)
                        ? height * 0.032
                        : height * 0.12),
                color: AppColors.backColor,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: height * 0.2),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: 'Let’s',
                                style: ralewayStyle.copyWith(
                                  fontSize: 25.0,
                                  color: AppColors.blueDarkColor,
                                  fontWeight: FontWeight.normal,
                                )),
                            TextSpan(
                              text: ' Sign In 👇',
                              style: ralewayStyle.copyWith(
                                fontWeight: FontWeight.w800,
                                color: AppColors.blueDarkColor,
                                fontSize: 25.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      Text(
                        'Hey, Enter your details to get sign in \nto your account.',
                        style: ralewayStyle.copyWith(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textColor,
                        ),
                      ),
                      const SizedBox(height: 3),
                      if(_localValue != "")
                        Text(_localValue,
                          style: ralewayStyle.copyWith(
                            fontSize: 27.0,
                            fontWeight: FontWeight.w100,
                            color: Colors.red,
                          ),
                        ),
                      SizedBox(height: height * 0.064),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text('Email',
                          style: ralewayStyle.copyWith(
                            fontSize: 12.0,
                            color: AppColors.blueDarkColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Container(
                        height: 50.0,
                        width: width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: AppColors.whiteColor,
                        ),
                        child: TextFormField(
                          onTap: () {
                            setState(() {
                              _errorEmailText = '';
                              _submittedEmail = false;
                            });
                          },
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (val) {
                            setState(() {
                              emailValue = val;
                            });
                          },
                          focusNode: emailFocus,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: IconButton(
                              onPressed: () {
                                emailFocus.requestFocus();
                              },
                              icon: Image.asset(AppIcons.emailIcon),
                            ),
                            contentPadding: const EdgeInsets.only(top: 11.0),
                            hintText: 'Enter Email',
                            hintStyle: ralewayStyle.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppColors.blueDarkColor.withOpacity(0.5),
                              fontSize: 12.0,
                            ),
                            errorText: _submittedEmail ? _errorEmailText : null,
                          ),
                        ),
                      ),

                      SizedBox(height: height * 0.014),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text('Password',
                          style: ralewayStyle.copyWith(
                            fontSize: 12.0,
                            color: AppColors.blueDarkColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Container(
                        height: 50.0,
                        width: width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: AppColors.whiteColor,
                        ),
                        child: TextFormField(
                          onTap: () {
                            setState(() {
                              _errorPasswordText = '';
                              _submittedPassword = false;
                            });
                          },
                          onChanged: (val) {
                            setState(() {
                              passwordValue = val;
                            });
                          },
                          focusNode: passwordFocus,
                          style: ralewayStyle.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppColors.blueDarkColor,
                            fontSize: 12.0,
                          ),
                          obscureText: isObscureText,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            suffixIcon: IconButton(
                              onPressed: () {
                                if (isObscureText) {
                                  setState(() {
                                    isObscureText = false;
                                  });
                                }
                                else {
                                  setState(() {
                                    isObscureText = true;
                                  });
                                }
                              },
                              icon: Icon(
                                isObscureText
                                    ? Icons.visibility_off_rounded
                                    : Icons.visibility_rounded,
                                size: 24,
                              ),
                            ),
                            prefixIcon: IconButton(
                              onPressed: () {
                                passwordFocus.requestFocus();
                              },
                              icon: Image.asset(AppIcons.lockIcon),
                            ),
                            contentPadding: const EdgeInsets.only(top: 16.0),
                            hintText: 'Enter Password',
                            hintStyle: ralewayStyle.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppColors.blueDarkColor.withOpacity(0.5),
                              fontSize: 12.0,
                            ),
                            errorText: _submittedPassword
                                ? _errorPasswordText
                                : null,
                          ),
                        ),
                      ),

                      SizedBox(height: height * 0.03),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, RoutesName.forgotPasswordScreen);
                          },
                          child: Text('Forgot Password?',
                            style: ralewayStyle.copyWith(
                              fontSize: 12.0,
                              color: AppColors.blueDarkColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: height * 0.05),

                      LayoutBuilder(
                        builder: (context, constraints) {
                          return Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Left-aligned button
                                Flexible(
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: emailValue.isNotEmpty ||
                                          passwordValue.isNotEmpty
                                          ? _submit
                                          : null,
                                      borderRadius: BorderRadius.circular(16.0),
                                      child: Ink(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: constraints.maxWidth *
                                              0.1, // 10% of the screen width
                                          vertical: 18.0,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              16.0),
                                          color: AppColors.blueDarkColor,
                                        ),
                                        child: Text('Login',
                                          style: ralewayStyle.copyWith(
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.whiteColor,
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                (kIsWeb) ? Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceEvenly,
                                  children: [
                                    IconButton(
                                      onPressed: _loginWithGoogle,
                                      icon: Image.asset(
                                        AppIcons.googleLogo,
                                        width: 50.0,  // Définissez la taille souhaitée ici
                                        height: 30.0, // Définissez la taille souhaitée ici
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: _loginWithFacebook,
                                      icon: Image.asset(
                                        AppIcons.facebookLogo,
                                        width: 50.0,  // Définissez la taille souhaitée ici
                                        height: 30.0, // Définissez la taille souhaitée ici
                                      ),
                                    ),
                                  ],
                                ) : (Platform.isAndroid || Platform.isIOS) ? Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceEvenly,
                                  children: [
                                    IconButton(
                                      onPressed: _loginWithGoogle,
                                      icon: Image.asset(
                                        AppIcons.googleLogo,
                                        width: 50.0,  // Définissez la taille souhaitée ici
                                        height: 30.0, // Définissez la taille souhaitée ici
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: _loginWithFacebook,
                                      icon: Image.asset(
                                        AppIcons.facebookLogo,
                                        width: 50.0,  // Définissez la taille souhaitée ici
                                        height: 30.0, // Définissez la taille souhaitée ici
                                      ),
                                    ),
                                  ],
                                ) : const SizedBox(),
                              ],
                            ),
                          );
                        },
                      ),

                      SizedBox(height: height * 0.03),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, RoutesName.signUpScreen);
                          },
                          child: Text('No account yet? Register',
                            style: ralewayStyle.copyWith(
                              fontSize: 12.0,
                              color: AppColors.blueDarkColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}