import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';
import 'package:realopt/utils/functions.dart';
import 'email_verify_screen.dart';
import 'login_screen.dart';
import '../constant/app_colors.dart';
import '../constant/app_icons.dart';
import '../constant/app_styles.dart';
import '../utils/responsive_widget.dart';
import 'package:page_transition/page_transition.dart';

class SingUpScreen extends StatefulWidget {
  const SingUpScreen({super.key});

  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {

  bool isObscureTextPassword = true;
  bool isObscureTextConfirm = true;

  bool _submittedEmail = false;
  bool _submittedPassword = false;
  bool _submittedConfirmPassword = false;

  String _errorEmailText = "";
  String _errorPasswordText = "";
  String _errorConfirmPasswordText = "";


  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();
  final confirmFocus = FocusNode();



  String emailValue = "";
  String passwordValue = "";
  String passwordConfirmValue = "";


  String _localValue = "";

  final GetStorage _storage = GetStorage();
  late bool statusLogin = false;
  late String haveToPass = "1";

  Future<void> _submit() async {


    setState(() {
      _submittedEmail = false;
      _submittedPassword = false;
      _submittedConfirmPassword = false;
    });

    if (passwordValue == null || passwordValue.isEmpty) {
      setState(() {
        _errorPasswordText =  'Can\'t be empty';
        _submittedPassword = true;
      });
    }
    else{

      // Check length
      if (passwordValue.length < 8) {
        setState(() {
          _errorPasswordText =  'At least 8 characters(digit,lowercase and uppercase letter and special char).';
          _submittedPassword = true;
        });
      }

      // Check for uppercase letters
      if (!RegExp(r'[A-Z]').hasMatch(passwordValue)) {
        setState(() {
          _errorPasswordText =  'At least 8 characters(digit,lowercase and uppercase letter and special char).';
          _submittedPassword = true;
        });
      }

      // Check for lowercase letters
      if (!RegExp(r'[a-z]').hasMatch(passwordValue)) {
        setState(() {
          _errorPasswordText =  'At least 8 characters(digit,lowercase and uppercase letter and special char).';
          _submittedPassword = true;
        });
      }

      // Check for digits
      if (!RegExp(r'[0-9]').hasMatch(passwordValue)) {
        setState(() {
          _errorPasswordText =  'At least 8 characters(digit,lowercase and uppercase letter and special char).';
          _submittedPassword = true;
        });
      }

      // Check for special characters
      if (!RegExp(r'[!@#$%^&*(),.?\":{}|<>]').hasMatch(passwordValue)) {
        setState(() {
          _errorPasswordText =  'At least 8 characters(digit,lowercase and uppercase letter and special char).';
          _submittedPassword = true;
        });
      }
    }






    if (passwordConfirmValue == null || passwordConfirmValue.isEmpty) {

      setState(() {
        _errorConfirmPasswordText =  'Can\'t be empty';
        _submittedConfirmPassword = true;
      });
    }
    else
    {

      if(passwordValue == null || passwordValue.isEmpty || passwordValue != passwordConfirmValue){
        _errorConfirmPasswordText =  'Invalid confirm password value.';
        _submittedConfirmPassword = true;
      }

    }

    if (emailValue == null || emailValue.isEmpty) {
      setState(() {
        _errorEmailText =  'Can\'t be empty';
        _submittedEmail = true;
      });
    }
    else{
      const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
          r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
          r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
          r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
          r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
          r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
          r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
      final regex = RegExp(pattern);
      if(!regex.hasMatch(emailValue)){
        setState(() {
          _errorEmailText = 'Enter a valid email address';
          _submittedEmail = true;
        });
      }
      else{
        var dataBody = await fetchdata("${dotenv.env['API_BASE_ADDRESS']}check_mail", "post", {"email":emailValue}, "");
        var response = jsonDecode(dataBody.toString());


        if (response['status'] == false)
        {

          setState(() {
            _errorEmailText = 'bad email format';
            _submittedEmail = true;
          });

        }
        else
        {
          if (response['msg'] == "Trash") {
            setState(() {
              _errorEmailText = 'Trash Mail is not allowed';
              _submittedEmail = true;
            });
          }
        }
      }
    }


    if(!_submittedEmail && !_submittedPassword && !_submittedConfirmPassword)
    {

      var dataBody = await fetchdata("${dotenv.env['API_BASE_ADDRESS']}newuser", "post", {"email":emailValue, "password":passwordValue}, "");
      var response = jsonDecode(dataBody.toString());
      if (response['status'] == false)
      {

        setState(() {
          _localValue = "User alrady exist";
        });

      }
      else
      {
        var dataBody = await fetchdata(
            "${dotenv.env['API_BASE_ADDRESS']}request_otp", "post",
            {"email": emailValue}, "");
        var response = jsonDecode(dataBody.toString());

        if (response["status"] == false) {
          setState(() {
            _localValue = "Connectivity problem. Check you are internet connection and try again later.";
          });
        }
        else{

          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.rightToLeft,
                  duration: const Duration(milliseconds: 800),
                  child: EmailVerify(theEmail: emailValue)));
        }


      }


    }



  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isObscureTextPassword = true;
    isObscureTextConfirm = true;

    _submittedEmail = false;
    _submittedPassword = false;
    _submittedConfirmPassword = false;

    _errorEmailText = "";
    _errorPasswordText = "";
    _errorConfirmPasswordText = "";

    emailValue = "";
    passwordValue = "";
    passwordConfirmValue = "";

    _localValue = "";
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    confirmFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.backColor,
      body: SizedBox(
        height: height,
        width: width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ResponsiveWidget.isSmallScreen(context) ? const SizedBox() : Expanded(
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
                margin: EdgeInsets.symmetric(horizontal: ResponsiveWidget.isSmallScreen(context)? height * 0.032 : height * 0.12),
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
                              text: ' Sign Up 👇',
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
                      Text('Hey, Enter your details to create a \nnew  account.',
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
                          onTap: (){
                            setState(() {
                              _errorEmailText =  '';
                              _submittedEmail = false;
                            });
                          },
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (val){
                            setState(() {
                              emailValue = val;
                            });
                          },
                          focusNode: emailFocus,
                          style: ralewayStyle.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppColors.blueDarkColor,
                            fontSize: 12.0,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: IconButton(
                              onPressed: (){
                                emailFocus.requestFocus();
                              },
                              icon: Image.asset(AppIcons.emailIcon),
                            ),
                            contentPadding: const EdgeInsets.only(top: 16.0),
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
                              _errorPasswordText =  '';
                              _submittedPassword = false;
                            });
                          },
                          onChanged: (val){
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
                          obscureText: isObscureTextPassword,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            suffixIcon: IconButton(
                              onPressed: (){
                                if(isObscureTextPassword){
                                  setState(() {
                                    isObscureTextPassword = false;
                                  });
                                }
                                else{
                                  setState(() {
                                    isObscureTextPassword = true;
                                  });
                                }
                              },
                              icon: Icon(
                                isObscureTextPassword
                                    ? Icons.visibility_off_rounded
                                    : Icons.visibility_rounded,
                                size: 24,
                              ),
                            ),
                            prefixIcon: IconButton(
                              onPressed: (){
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
                            errorText: _submittedPassword ? _errorPasswordText : null,
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.014),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text('Confirm Password',
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
                              _errorConfirmPasswordText =  '';
                              _submittedConfirmPassword = false;
                            });
                          },
                          onChanged: (val){
                            setState(() {
                              passwordConfirmValue = val;
                            });
                          },
                          focusNode: confirmFocus,
                          style: ralewayStyle.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppColors.blueDarkColor,
                            fontSize: 12.0,
                          ),
                          obscureText: isObscureTextConfirm,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            suffixIcon: IconButton(
                              onPressed: (){
                                if(isObscureTextConfirm){
                                  setState(() {
                                    isObscureTextConfirm = false;
                                  });
                                }
                                else{
                                  setState(() {
                                    isObscureTextConfirm = true;
                                  });
                                }
                              },
                              icon: Icon(
                                isObscureTextConfirm
                                    ? Icons.visibility_off_rounded
                                    : Icons.visibility_rounded,
                                size: 24,
                              ),
                            ),
                            prefixIcon: IconButton(
                              onPressed: (){
                                confirmFocus.requestFocus();
                              },
                              icon: Image.asset(AppIcons.lockIcon),
                            ),
                            contentPadding: const EdgeInsets.only(top: 16.0),
                            hintText: 'Enter Again Password',
                            hintStyle: ralewayStyle.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppColors.blueDarkColor.withOpacity(0.5),
                              fontSize: 12.0,
                            ),
                            errorText: _submittedConfirmPassword ? _errorConfirmPasswordText : null,
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.05),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: emailValue.isNotEmpty || passwordValue.isNotEmpty || passwordConfirmValue.isNotEmpty ? _submit : null,
                          borderRadius: BorderRadius.circular(16.0),
                          child: Ink(
                            padding: const EdgeInsets.symmetric(horizontal: 70.0, vertical: 18.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                              color: AppColors.blueDarkColor,
                            ),
                            child: Text('Sign Up',
                              style: ralewayStyle.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.whiteColor,
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.03),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: (){
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    duration: const Duration(milliseconds: 400),
                                    child: const LoginScreen()));
                          },
                          child: Text('Already have an account? Sign In',
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