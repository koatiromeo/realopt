import 'package:realopt/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:realopt/utils/functions.dart';
import 'package:get_storage/get_storage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:realopt/utils/responsive.dart';
import 'package:realopt/screens/dashboard_screen.dart';
import 'package:realopt/constants/styles.dart';
import 'package:realopt/utils/responsive_widget.dart';
import 'dart:io';
import 'dart:convert';

class CompleteInvestorProfileScreen extends StatefulWidget {
  late  String theemail;

  CompleteInvestorProfileScreen({super.key, required this.theemail});

  @override
  State<CompleteInvestorProfileScreen> createState() => _CompleteInvestorProfileScreenState();
}

class _CompleteInvestorProfileScreenState extends State<CompleteInvestorProfileScreen> {
  XFile? _imageFile;
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  bool requestAsWork = false;
  final GetStorage _storage = GetStorage();

  Future<void> _performApiRequest(String url, String method, Map<String, String> JsonData, String jwtToken) async {
    // Show the SnackBar
    _scaffoldMessengerKey.currentState?.showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 20),
            Text('Processing Data...'),
          ],
        ),
        duration: Duration(days: 1), // Keep the SnackBar until dismissed
      ),
    );

    try {
      // Simulate a network request
      await Future.delayed(const Duration(seconds: 5));
      var dataBody = await fetchdata(url, method, JsonData, jwtToken);
      var reponse = jsonDecode(dataBody.toString());
      if (reponse['status'] == false)
      {
        setState(() {
          requestAsWork = false;
        });
      }
      else{
        setState(() {
          requestAsWork = true;
        });
      }
      _scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
      _showResultSnackBar('Processing Data Successful.');
    } catch (e) {
      // Handle error
      _scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
      _showResultSnackBar('Processing Data Failed. Try Check Your Internet Connection.');
    }
  }

  void _showResultSnackBar(String message) {
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }


  final ImagePicker _picker = ImagePicker();
  bool showPassword = false;
  bool isPhoneValidated = false;

  final FocusNode PhoneFocusNode = FocusNode();

  final _UserTypeList = ["Investor", "broker"];
  String _SelectedTypeUser = "";
  String _UserFirstName = "";
  String _UserLastName = "";
  String _UserPhoneNumber = "";
  final TextEditingController _controllerTextEditingFirstName = TextEditingController();
  final TextEditingController _controllerTextEditingLastName = TextEditingController();
  final TextEditingController _controllerPhoneEditing =  TextEditingController();



  void takePhoto(ImageSource source) async{
    final pickedFile = await _picker.pickImage(source: source);
    setState(() {
      _imageFile = pickedFile ;
    });
  }
  Widget bottomSheet(){
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20
      ),
      child: Column(
        children: <Widget>[
          const Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton.icon(
                icon: const Icon(Icons.camera),
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                label: const Text("Camera"),
              ),
              const SizedBox(width: 30,),
              TextButton.icon(
                icon: const Icon(Icons.image),
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                label: const Text("Gallery"),
              ),
            ],
          )
        ],
      ),
    );
  }



  final _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _SelectedTypeUser = _UserTypeList[0];
  }
  @override
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
                      const Center(
                          child: Text(
                            "Complete Your Profile",
                            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                          )
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Form(
                          key: _formkey,
                          child: Column(
                            children: [

                              Center(
                                child: Stack(
                                  children: [
                                    Container(
                                      width: 130,
                                      height: 130,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 4,
                                              color: Theme.of(context).scaffoldBackgroundColor),
                                          boxShadow: [
                                            BoxShadow(
                                                spreadRadius: 2,
                                                blurRadius: 10,
                                                color: Colors.black.withOpacity(0.1),
                                                offset: const Offset(0, 10))
                                          ],
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image:   _imageFile == null ? const AssetImage("lib/assets/images/default-user.png"):  FileImage(File(_imageFile!.path)) as ImageProvider<Object>
                                          )
                                      ),
                                    ),
                                    Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              width: 4,
                                              color: Theme.of(context).scaffoldBackgroundColor,
                                            ),
                                            color: AppColors.colorPrimary,
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              // Add your onPressed code here!
                                              showModalBottomSheet(
                                                  context: context,
                                                  builder: ((builder) => bottomSheet())
                                              );
                                            },
                                            child: const Icon(
                                              Icons.edit,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 35,
                              ),
                              buildTextField("First Name", "John", false, true),
                              buildTextField("Last Name", "Smith", false, false),
                              DropdownButtonFormField(
                                value: _SelectedTypeUser,
                                items: _UserTypeList.map(
                                        (e) => DropdownMenuItem(value: e,child: Text(e),)
                                ).toList(),
                                onChanged: (typeuser) {
                                  setState(() {
                                    _SelectedTypeUser = typeuser!;
                                    print(_SelectedTypeUser);
                                  });
                                },
                                decoration: const InputDecoration(
                                    labelText: "Type User",
                                    prefixIcon: Icon(
                                        Icons.accessibility_new_rounded
                                    )
                                ),
                              ),
                              const SizedBox(
                                height: 35,
                              ),
                              IntlPhoneField(
                                focusNode: PhoneFocusNode,
                                validator: (userInput) {
                                  try {
                                    if (userInput!.number.isEmpty) {
                                      setState(() {
                                        isPhoneValidated = false;
                                      });
                                      return null;
                                    }
                                    // Ensure it is only digits and optional '+' or '00' for the country code.
                                    if (userInput.isValidNumber()) {
                                      setState(() {
                                        isPhoneValidated = true;
                                      });
                                      return null;
                                    }
                                    return null;
                                  } catch (e) {
                                    return 'Please enter a valid phone number';
                                  }
                                  // Return null when the input is valid
                                },
                                controller: _controllerPhoneEditing,
                                initialCountryCode: 'CA',
                                decoration: const InputDecoration(
                                  labelText: 'Phone Number',
                                ),
                                onChanged: (phone){
                                  _UserPhoneNumber = phone.completeNumber;
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  OutlinedButton(
                                    onPressed: () {
                                      _controllerPhoneEditing.clear();
                                      _controllerTextEditingFirstName.clear();
                                      _controllerTextEditingLastName.clear();
                                      setState(() {
                                        _SelectedTypeUser = _UserTypeList[0];
                                      });
                                    },
                                    style: OutlinedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(horizontal: 50),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: const Text(
                                      "CANCEL",
                                      style: TextStyle(
                                        fontSize: 14,
                                        letterSpacing: 2.2,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      if(_formkey.currentState!.validate()){
                                        if(isPhoneValidated)
                                        {
                                          _performApiRequest(
                                              "${dotenv.env['API_BASE_ADDRESS']}add_profile",
                                              "post",
                                              {
                                                "email":widget.theemail,
                                                "first_name":_UserFirstName,
                                                "last_name":_UserLastName,
                                                "user_type":_SelectedTypeUser,
                                                "phone_number":_UserPhoneNumber,
                                                "image_base64_encode": _imageFile == null ? "noImage" : base64Encode(_imageFile?.readAsBytes() as List<int>)
                                              },
                                              _storage.read("userSession")
                                          );
                                          if(requestAsWork)
                                          {
                                            if(_SelectedTypeUser == "broker"){

                                              Navigator.push(
                                                  context,
                                                  PageTransition(
                                                      type: PageTransitionType.rightToLeft,
                                                      duration: const Duration(milliseconds: 400),
                                                      child: DashboardScreen()));

                                            }
                                            else{

                                              Navigator.push(
                                                  context,
                                                  PageTransition(
                                                      type: PageTransitionType.rightToLeft,
                                                      duration: const Duration(milliseconds: 400),
                                                      child: DashboardScreen()));

                                            }
                                          }

                                        }
                                        else{
                                          PhoneFocusNode.requestFocus();
                                        }

                                      }

                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.colorPrimary, // Background color
                                      padding: const EdgeInsets.symmetric(horizontal: 50),
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: const Text(
                                      "SAVE",
                                      style: TextStyle(
                                        fontSize: 14,
                                        letterSpacing: 2.2,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              )

                            ],
                          )),

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



  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField, bool isFirstName) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextFormField(
        validator: (value){
          if(value ==null || value.isEmpty){
            return 'This field is required';
          }
          else{
            return null;
          }
        },
        controller: isFirstName ? _controllerTextEditingFirstName : _controllerTextEditingLastName,
        onChanged: (val){
          if(isFirstName)
          {

            setState(() {
              _UserFirstName = val;
            });

          }
          else
          {
            setState(() {
              _UserLastName = val;
            });
          }

        },
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
              onPressed: () {
                setState(() {
                  showPassword = !showPassword;
                });
              },
              icon: const Icon(
                Icons.remove_red_eye,
                color: Colors.grey,
              ),
            )
                : null,
            contentPadding: const EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
}