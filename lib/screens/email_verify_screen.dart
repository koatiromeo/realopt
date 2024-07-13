import 'dart:convert';
import 'email_success_screen.dart';
import '../utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pinput/pinput.dart';
import 'package:realopt/utils/responsive.dart';
import '../constant/app_colors.dart';
import '../constant/app_styles.dart';
import '../utils/responsive_widget.dart';


class EmailVerify extends StatefulWidget {
  late String theEmail;
  EmailVerify({Key? key, required this.theEmail}) : super(key: key);
  @override
  State<EmailVerify> createState() => _EmailVerifyState();
}

class _EmailVerifyState extends State<EmailVerify> {
  String email_message = "";
  bool can_pass = false;
  String opt_enter = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    can_pass = false;
    opt_enter = "";
    email_message = "";
  }


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );

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
                      Image.asset(
                        'lib/assets/images/logo.png',
                        width: 150,
                        height: 150,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      const Text(
                        "Email Verification",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        email_message,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Pinput(
                        length: 6,
                        showCursor: true,
                        onCompleted: (pin){
                          setState(() {
                            final numericRegex =RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');
                            if(numericRegex.hasMatch(pin)){
                              setState(() {
                                can_pass = true;
                                opt_enter = pin;
                              });
                            }
                            else{
                              setState(() {
                                email_message = "Enter a valid otp code";
                                can_pass = false;
                              });
                            }
                          });
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.blueDarkColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            onPressed: () async{
                              if(can_pass){
                                var dataBody = await fetchdata("${dotenv.env['API_BASE_ADDRESS']}verify_otp", "post", {"email":widget.theEmail, "otp":opt_enter}, "");
                                var response = jsonDecode(dataBody.toString());
                                if(response["status"] == false){
                                  setState(() {
                                    email_message = response["msg"];
                                  });
                                }
                                else{
                                  var dataBody = await fetchdata("${dotenv.env['API_BASE_ADDRESS']}activate_user", "post", {"email":widget.theEmail}, "");
                                  var response = jsonDecode(dataBody.toString());
                                  if(response["status"] == true){
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            type: PageTransitionType.rightToLeft,
                                            duration: const Duration(milliseconds: 800),
                                            child: const EmailSuccess()));
                                  }
                                  else{
                                    setState(() {
                                      email_message = response["msg"];
                                    });
                                  }
                                }

                              }
                            },
                            child: const Text(
                              "Verify Email",
                              style: TextStyle(
                                  color: AppColors.whiteColor
                              ),
                            )),
                      ),
                      Row(
                        children: [
                          TextButton(
                              onPressed: () async{
                                var data_body = await fetchdata("${dotenv.env['API_BASE_ADDRESS']}request_otp", "post", {"email":widget.theEmail}, "");
                                var reponse = jsonDecode(data_body.toString());


                                if(reponse["status"] == false){
                                  setState(() {
                                    email_message = "Internet connection error. Verify Your Internet connexion and resend back the code";
                                  });

                                }
                                else{
                                  setState(() {
                                    email_message = "The code have been recent to ";
                                    int size_email = widget.theEmail.length;
                                    int position_of_email = widget.theEmail.indexOf("@");
                                    int position_of_dot = widget.theEmail.indexOf(".");
                                    for(var i=0; i < size_email; i++ )
                                    {
                                      if(i == 0){
                                        email_message = email_message + widget.theEmail[i].toString();
                                      }
                                      else{
                                        if(i == size_email-1 || i == position_of_email-1 || i == position_of_email || i == position_of_email + 1 || i == position_of_dot - 1 || i == position_of_dot || i == position_of_dot + 1){
                                          email_message = email_message + widget.theEmail[i].toString();
                                        }
                                        else{
                                          email_message = email_message + "*".toString();
                                        }
                                      }
                                    }

                                    email_message =  email_message + ". ".toString();
                                    email_message =  email_message + "You have 2 minutes to fill the valide otp code to verify your email.".toString();
                                  });

                                }
                              },
                              child: const Text(
                                "Have not receive the code ? Send Back the code",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 13
                                ),
                              ))
                        ],
                      )
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



