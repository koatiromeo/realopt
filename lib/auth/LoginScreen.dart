import 'package:flutter/material.dart';
import 'package:realopt/auth/ForgotPasswordScreen.dart';
import 'package:realopt/auth/SingUpScreen.dart';
import 'package:realopt/dashboard/config/responsive.dart';
import 'package:realopt/dashboard/dashboard.dart';
import 'app_colors.dart';
import 'app_icons.dart';
import 'app_styles.dart';
import 'responsive_widget.dart';
import 'package:page_transition/page_transition.dart';

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

  void _submit() {

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
    }

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


    if(!_submittedEmail && !_submittedPassword){
      print("On  effectue la connexion");
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
                        Text('Hey, Enter your details to get sign in \nto your account.',
                          style: ralewayStyle.copyWith(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textColor,
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
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: IconButton(
                                onPressed: (){
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
                            obscureText: isObscureText,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                                onPressed: (){

                                  if(isObscureText){
                                    setState(() {
                                      isObscureText = false;
                                    });
                                  }
                                  else{
                                    setState(() {
                                      isObscureText = true;
                                    });
                                  }
                                },
                                icon:  Icon(
                                  isObscureText
                                      ? Icons.visibility_off_rounded
                                      : Icons.visibility_rounded,
                                  size: 24,
                                ),
                              ),
                              prefixIcon:IconButton(
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
                                      child: const ForgotPasswordScreen()));
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
                                children: [
                                  // Left-aligned button
                                  Flexible(
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: emailValue.isNotEmpty || passwordValue.isNotEmpty ? _submit : null,
                                        borderRadius: BorderRadius.circular(16.0),
                                        child: Ink(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: constraints.maxWidth * 0.1, // 10% of the screen width
                                            vertical: 18.0,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(16.0),
                                            color: AppColors.blueDarkColor,
                                          ),
                                          child: Text('Sign In',
                                            style: ralewayStyle.copyWith(
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.whiteColor,
                                              fontSize: 9.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  Spacer(), // Spacer pushes the next button to the right

                                  // Right-aligned button
                                  Flexible(
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: (){
                                          Navigator.push(
                                              context,
                                              PageTransition(
                                                  type: PageTransitionType.rightToLeft,
                                                  duration: const Duration(milliseconds: 400),
                                                  child: Dashboard()));
                                        },
                                        borderRadius: BorderRadius.circular(16.0),
                                        child: Ink(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: constraints.maxWidth * 0.1, // 10% of the screen width
                                            vertical: 18.0,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(16.0),
                                            color: AppColors.blueDarkColor,
                                          ),
                                          child: Text('Skip Now',
                                            style: ralewayStyle.copyWith(
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.whiteColor,
                                              fontSize: 9.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
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
                                      child: const SingUpScreen()));
                            },
                            child: Text('No account yet? Sign UP',
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