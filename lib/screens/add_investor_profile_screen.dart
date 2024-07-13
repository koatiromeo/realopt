import 'package:flutter/material.dart';
import 'package:realopt/components/dashboard/ai_floating_action_button.dart';
import 'package:realopt/components/dashboard/appBarActionItems.dart';
import 'package:realopt/components/dashboard/header.dart';
import 'package:realopt/components/dashboard/paymentDetailList.dart';
import 'package:realopt/components/dashboard/sideMenu.dart';
import 'package:realopt/utils/responsive.dart';
import 'package:realopt/utils/size_config.dart';
import 'package:realopt/constant/colors.dart';
import 'package:realopt/form/custom_text_form_field.dart';
import 'package:realopt/form/date_picker_form_field.dart';
import 'package:realopt/form/phone_form_field.dart';
import 'package:realopt/form/responsive_form.dart';
import 'package:realopt/form/searchable_dropdown.dart';
import 'package:realopt/model/employment.dart';

import '../model/actif.dart';



class AddInvestorProfileScreen extends StatefulWidget {
  const AddInvestorProfileScreen({super.key});

  @override
  State<AddInvestorProfileScreen> createState() => _AddInvestorProfileScreenState();
}

class _AddInvestorProfileScreenState extends State<AddInvestorProfileScreen> {

  int currentStep = 0;
  int selectedIndex = -1;
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();


  //Variable for Step 1
  // First Name
  TextEditingController step1FirstNameController = TextEditingController();
  String step1FirstNameErrorText = "";

  // Last Name
  TextEditingController step1LastNameController = TextEditingController();
  String step1LastNameErrorText = "";

  //Email
  TextEditingController step1EmailController = TextEditingController();
  String step1EmailErrorText = "";

  //Status DropDown
  TextEditingController step1StatusDropDownController = TextEditingController();
  List<String> step1StatusDropDownList = [
    "Single",
    "Married",
    "Divorced",
    "Widowed",
    "Employed",
    "Unemployed",
    "Student",
    "Retired",
    "Self-Employed",
    "Homemaker",
    "Freelancer",
    "In a Relationship",
    "Separated",
    "Engaged",
  ];
  String  step1StatusDropDownErrorText = "";

  //Status DropDown
  TextEditingController step1GenreDropdownController = TextEditingController();
  List<String> step1GenreDropdownList = [
    "Single",
    "Married",
    "Divorced",
    "Widowed",
    "Employed",
    "Unemployed",
    "Student",
    "Retired",
    "Self-Employed",
    "Homemaker",
    "Freelancer",
    "In a Relationship",
    "Separated",
    "Engaged",
  ];
  String  step1GenreDropdownErrorText = "";

  //Birth Date Picker
  TextEditingController step1BirthDateController = TextEditingController();
  String  step1BirthDateErrorText = "";

  //Max Investment Duration Years
  TextEditingController step1MaxInvestmentDurationYearsController = TextEditingController();
  String step1MaxInvestmentDurationYearsErrorText = "";

  //Max Cash Available To Invest
  TextEditingController step1MaxCashAvailableToInvestController = TextEditingController();
  String step1MaxCashAvailableToInvestErrorText = "";

  //Federal Income Tax Rate
  TextEditingController step1FederalIncomeTaxRateController = TextEditingController();
  String step1FederalIncomeTaxRateErrorText = "";

  //Provincial Income Tax Rate
  TextEditingController step1ProvincialIncomeTaxRateController = TextEditingController();
  String step1ProvincialIncomeTaxRateErrorText = "";

  //Sin
  TextEditingController step1SinController = TextEditingController();
  String step1SinErrorText = "";

  //Number Of Dependents
  TextEditingController step1NumberOfDependentsController = TextEditingController();
  String step1NumberOfDependentsErrorText = "";

  //Consent
  TextEditingController step1ConsentController = TextEditingController();
  String step1ConsentErrorText = "";

  //Address DropDown
  TextEditingController step1AddressDropdownController = TextEditingController();
  List<String> step1AddressDropdownList = [
    "Single",
    "Married",
    "Divorced",
    "Widowed",
    "Employed",
    "Unemployed",
    "Student",
    "Retired",
    "Self-Employed",
    "Homemaker",
    "Freelancer",
    "In a Relationship",
    "Separated",
    "Engaged",
  ];
  String  step1AddressDropdownErrorText = "";

  //City DropDown
  TextEditingController step1CityDropdownController = TextEditingController();
  List<String> step1CityDropdownList = [
    "Single",
    "Married",
    "Divorced",
    "Widowed",
    "Employed",
    "Unemployed",
    "Student",
    "Retired",
    "Self-Employed",
    "Homemaker",
    "Freelancer",
    "In a Relationship",
    "Separated",
    "Engaged",
  ];
  String  step1CityDropdownErrorText = "";

  //Region DropDown
  TextEditingController step1RegionDropdownController = TextEditingController();
  List<String> step1RegionDropdownList = [
    "Single",
    "Married",
    "Divorced",
    "Widowed",
    "Employed",
    "Unemployed",
    "Student",
    "Retired",
    "Self-Employed",
    "Homemaker",
    "Freelancer",
    "In a Relationship",
    "Separated",
    "Engaged",
  ];
  String  step1RegionDropdownErrorText = "";

  //Postal Code
  TextEditingController step1PostalCodeController = TextEditingController();
  String step1PostalCodeErrorText = "";

  //Living Situation DropDown
  TextEditingController step1LivingSituationDropdownController = TextEditingController();
  List<String> step1LivingSituationDropdownList = [
    "Single",
    "Married",
    "Divorced",
    "Widowed",
    "Employed",
    "Unemployed",
    "Student",
    "Retired",
    "Self-Employed",
    "Homemaker",
    "Freelancer",
    "In a Relationship",
    "Separated",
    "Engaged",
  ];
  String  step1LivingSituationDropdownErrorText = "";

  //Phone Number
  TextEditingController step1PhoneNumberController = TextEditingController();
  String step1PhoneNumberErrorText = "";

  //Variable for Step 2
  //List Of Employments
  late List<Employment> employments = List.empty(growable: true);

  //Start Date
  TextEditingController step2StartDateController = TextEditingController();
  String  step2StartDateErrorText = "";

  //End Date
  TextEditingController step2EndDateController = TextEditingController();
  String  step2EndDateErrorText = "";

  //Employment Title
  TextEditingController step2EmploymentTitleController = TextEditingController();
  String step2EmploymentTitleErrorText = "";

  //Occupation
  TextEditingController step2OccupationController = TextEditingController();
  String step2OccupationErrorText = "";

  //Number Year In The Sector
  TextEditingController step2NumberYearInTheSectorController = TextEditingController();
  String step2NumberYearInTheSectorErrorText = "";

  //Annual Income
  TextEditingController step2AnnualIncomeController = TextEditingController();
  String step2AnnualIncomeErrorText = "";

  //Income Type
  TextEditingController step2IncomeTypeDropdownController = TextEditingController();
  List<String> step2IncomeTypeDropdownList = [
    "Single",
    "Married",
    "Divorced",
    "Widowed",
    "Employed",
    "Unemployed",
    "Student",
    "Retired",
    "Self-Employed",
    "Homemaker",
    "Freelancer",
    "In a Relationship",
    "Separated",
    "Engaged",
  ];
  String  step2IncomeTypeDropdownErrorText = "";

  //Employment Type
  TextEditingController step2EmploymentTypeDropdownController = TextEditingController();
  List<String> step2EmploymentTypeDropdownList = [
    "Single",
    "Married",
    "Divorced",
    "Widowed",
    "Employed",
    "Unemployed",
    "Student",
    "Retired",
    "Self-Employed",
    "Homemaker",
    "Freelancer",
    "In a Relationship",
    "Separated",
    "Engaged",
  ];
  String  step2EmploymentTypeDropdownErrorText = "";

  //Employer Name
  TextEditingController step2EmployerNameController = TextEditingController();
  String step2EmployerNameErrorText = "";

  //Employer Phone
  TextEditingController step2EmployerPhoneController = TextEditingController();
  String step2EmployerPhoneErrorText = "";

  //Employer Address
  TextEditingController step2EmployerAddressController = TextEditingController();
  String step2EmployerAddressErrorText = "";

  //Employer Postal Code
  TextEditingController step2EmployerPostalCodeController = TextEditingController();
  String step2EmployerPostalCodeErrorText = "";


  //Employer City Dropdown
  TextEditingController step2EmployerCityDropdownController = TextEditingController();
  List<String> step2EmployerCityDropdownList = [
    "Single",
    "Married",
    "Divorced",
    "Widowed",
    "Employed",
    "Unemployed",
    "Student",
    "Retired",
    "Self-Employed",
    "Homemaker",
    "Freelancer",
    "In a Relationship",
    "Separated",
    "Engaged",
  ];
  String step2EmployerCityDropdownErrorText = "";

  //Employer Region Dropdown
  TextEditingController step2EmployerRegionDropdownController = TextEditingController();
  List<String> step2EmployerRegionDropdownList = [
    "Single",
    "Married",
    "Divorced",
    "Widowed",
    "Employed",
    "Unemployed",
    "Student",
    "Retired",
    "Self-Employed",
    "Homemaker",
    "Freelancer",
    "In a Relationship",
    "Separated",
    "Engaged",
  ];
  String step2EmployerRegionDropdownErrorText = "";

  //Employer Country Dropdown
  TextEditingController step2EmployerCountryDropdownController = TextEditingController();
  List<String> step2EmployerCountryDropdownList = [
    "Single",
    "Married",
    "Divorced",
    "Widowed",
    "Employed",
    "Unemployed",
    "Student",
    "Retired",
    "Self-Employed",
    "Homemaker",
    "Freelancer",
    "In a Relationship",
    "Separated",
    "Engaged",
  ];
  String step2EmployerCountryDropdownErrorText = "";


  //Path To File
  TextEditingController step2PathToFileController = TextEditingController();
  String step2PathToFileErrorText = "";

  //Status
  TextEditingController step2StatusController = TextEditingController();
  String step2StatusErrorText = "";

  //Variable for Step 3
  //List Of Employments
  late List<Actif> actifs = List.empty(growable: true);

  //Actif Type Dropdown
  TextEditingController step3ActifTypeDropdownController = TextEditingController();
  List<String> step3ActifTypeDropdownList = [
    "Single",
    "Married",
    "Divorced",
    "Widowed",
    "Employed",
    "Unemployed",
    "Student",
    "Retired",
    "Self-Employed",
    "Homemaker",
    "Freelancer",
    "In a Relationship",
    "Separated",
    "Engaged",
  ];
  String step3ActifTypeDropdownErrorText = "";


  //Actif Name
  TextEditingController step3ActifNameController = TextEditingController();
  String step3ActifNameErrorText = "";

  //Actif Description
  TextEditingController step3ActifDescriptionController = TextEditingController();
  String step3ActifDescriptionErrorText = "";

  //Actif Current Value
  TextEditingController step3ActifCurrentValueController = TextEditingController();
  String step3ActifCurrentValueErrorText = "";

  List<Step>  getSteps() => [
    Step(
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 0,
        title: const Text("General Information"),
        content: ResponsiveForm.responsiveForm(
            children: [
              SizedBox(
                width: 200,
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: CustomTextFormField(title: "First Name *", dataType: TextInputType.name, errorText: step1FirstNameErrorText, dataController: step1FirstNameController),
                ),
              ),
              SizedBox(
                width: 200,
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: CustomTextFormField(title: "Last Name *", dataType: TextInputType.name,  errorText: step1LastNameErrorText, dataController: step1LastNameController),
                ),
              ),
              SizedBox(
                width: 200,
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: CustomTextFormField(title: "Email *",  dataType: TextInputType.emailAddress,  errorText: step1EmailErrorText, dataController: step1EmailController),
                ),
              ),
              SizedBox(
                width: 200,
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: SearchableDropdown(
                    listItems: step1StatusDropDownList,
                    addTitle: "Add new status",
                    labelTitle: "Select Social Status *:",
                    hintAddText: "Enter new status",
                    hintSearchText: "Search for a status...",
                    dataController: step1StatusDropDownController,
                    errorText: step1StatusDropDownErrorText,
                  ),
                ),
              ),
              SizedBox(
                width: 200,
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: SearchableDropdown(
                    listItems: step1GenreDropdownList,
                    addTitle: "Add new genre",
                    labelTitle: "Select genre *:",
                    hintAddText: "Enter new genre",
                    hintSearchText: "Search for a genre...",
                    dataController: step1GenreDropdownController,
                    errorText: step1GenreDropdownErrorText,
                  ),
                ),
              ),
              SizedBox(
                width: 200,
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: DatePickerFormField(title: "Birth Date *:", hintSelectText: "Select a Date", dataController: step1BirthDateController, errorText: step1BirthDateErrorText),
                ),
              ),
              SizedBox(
                width: 200,
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: CustomTextFormField(title: "Max Investment Duration Years *",  dataType: TextInputType.text,  errorText: step1MaxInvestmentDurationYearsErrorText, dataController: step1MaxInvestmentDurationYearsController),
                ),
              ),
              SizedBox(
                width: 200,
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: CustomTextFormField(title: "Max Cash Available To Invest *",  dataType: TextInputType.number,  errorText: step1MaxCashAvailableToInvestErrorText, dataController: step1MaxCashAvailableToInvestController),
                ),
              ),
              SizedBox(
                width: 200,
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: CustomTextFormField(title: "Federal Income Tax Rate *",  dataType: TextInputType.number,  errorText: step1FederalIncomeTaxRateErrorText, dataController: step1FederalIncomeTaxRateController),
                ),
              ),
              SizedBox(
                width: 200,
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: CustomTextFormField(title: "Provincial Income Tax Rate *",  dataType: TextInputType.number,  errorText: step1ProvincialIncomeTaxRateErrorText, dataController: step1ProvincialIncomeTaxRateController),
                ),
              ),
              SizedBox(
                width: 200,
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: CustomTextFormField(title: "Sin *",  dataType: TextInputType.number,  errorText: step1SinErrorText, dataController: step1SinController),
                ),
              ),
              SizedBox(
                width: 200,
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: CustomTextFormField(title: "Number Of Dependents *",  dataType: TextInputType.number,  errorText: step1NumberOfDependentsErrorText, dataController: step1NumberOfDependentsController),
                ),
              ),
              SizedBox(
                width: 200,
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: CustomTextFormField(title: "Consent *",  dataType: TextInputType.number,  errorText: step1ConsentErrorText, dataController: step1ConsentController),
                ),
              ),
              SizedBox(
                width: 200,
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: SearchableDropdown(
                      listItems: step1AddressDropdownList,
                      addTitle: "Add new address",
                      labelTitle: "Select address *:",
                      hintAddText: "Enter new address",
                      hintSearchText: "Search for a address...",
                      dataController: step1AddressDropdownController,
                      errorText: step1AddressDropdownErrorText
                  ),
                ),
              ),
              SizedBox(
                width: 200,
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: SearchableDropdown(
                      listItems: step1CityDropdownList,
                      addTitle: "Add new city",
                      labelTitle: "Select city *:",
                      hintAddText: "Enter new city",
                      hintSearchText: "Search for a city...",
                      dataController: step1CityDropdownController,
                      errorText: step1CityDropdownErrorText
                  ),
                ),
              ),
              SizedBox(
                width: 200,
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: SearchableDropdown(
                    listItems: step1RegionDropdownList,
                    addTitle: "Add new region",
                    labelTitle: "Select region *:",
                    hintAddText: "Enter new region",
                    hintSearchText: "Search for a region...",
                    dataController: step1RegionDropdownController,
                    errorText: step1RegionDropdownErrorText,
                  ),
                ),
              ),
              SizedBox(
                width: 200,
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: CustomTextFormField(title: "Postal Code *",  dataType: TextInputType.text,  errorText: step1PostalCodeErrorText, dataController: step1PostalCodeController),
                ),
              ),
              SizedBox(
                width: 200,
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: SearchableDropdown(
                      listItems: step1LivingSituationDropdownList,
                      addTitle: "Add new living situation",
                      labelTitle: "Select living situation *:",
                      hintAddText: "Enter new living situation",
                      hintSearchText: "Search for a living situation...",
                      dataController: step1LivingSituationDropdownController,
                      errorText: step1LivingSituationDropdownErrorText
                  ),
                ),
              ),
              SizedBox(
                width: 200,
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: PhoneFormField(
                    title:  "Phone Number *:",
                    hintText:  "Enter Your Phone Number",
                    errorText: step1PhoneNumberErrorText,
                    dataController: step1PhoneNumberController,
                  ),
                ),
              ),

            ]
        )
    ),
    Step(
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 1,
        title: const Text("Job"),
        content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                children: [
                  ResponsiveForm.responsiveForm(
                      children: [
                        SizedBox(
                          width: 200,
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: DatePickerFormField(dataController: step2StartDateController, title: "Start Date", hintSelectText: "Select A Employment Start Date",  errorText: step2StartDateErrorText),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: DatePickerFormField(dataController: step2EndDateController, title: "End Date", hintSelectText: "Select A Employment End Date", errorText: step2EndDateErrorText),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: Padding(
                            padding:  const EdgeInsets.all(0.0),
                            child: CustomTextFormField(title: "Employment Title", dataType: TextInputType.text, errorText: step2EmploymentTitleErrorText, dataController: step2EmploymentTitleController),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: CustomTextFormField(title: "Occupation", dataType: TextInputType.text, errorText: step2OccupationErrorText, dataController: step2OccupationController),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: CustomTextFormField(title: "Number Year In The Sector", dataType: TextInputType.text, errorText: step2NumberYearInTheSectorErrorText, dataController: step2NumberYearInTheSectorController),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: CustomTextFormField(title: "Annual Income", dataType: TextInputType.number, errorText: step2AnnualIncomeErrorText, dataController: step2AnnualIncomeController),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: SearchableDropdown(
                              listItems: step2IncomeTypeDropdownList,
                              addTitle: "Add new Income Type",
                              labelTitle: "Select Income Type *:",
                              hintAddText: "Enter new Income Type",
                              hintSearchText: "Search for a income type...",
                              dataController: step2IncomeTypeDropdownController,
                              errorText: step2IncomeTypeDropdownErrorText,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: SearchableDropdown(
                              listItems: step2EmploymentTypeDropdownList,
                              addTitle: "Add new Employment Type",
                              labelTitle: "Select Employment Type *:",
                              hintAddText: "Enter new Employment Type",
                              hintSearchText: "Search for a employment type...",
                              dataController: step2EmploymentTypeDropdownController,
                              errorText: step2EmploymentTitleErrorText,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: CustomTextFormField(title: "Employer Name", dataType: TextInputType.text, dataController: step2EmployerNameController, errorText: step2EmployerNameErrorText),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: CustomTextFormField(title:  "Employer Address", dataType: TextInputType.text, errorText: step2EmployerAddressErrorText, dataController: step2EmployerAddressController),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: SearchableDropdown(
                                listItems: step2EmployerCityDropdownList,
                                addTitle: "Add new Employer city",
                                labelTitle: "Select Employer city *:",
                                hintAddText: "Enter new Employer city",
                                hintSearchText: "Search for the employer city...",
                                dataController: step2EmployerCityDropdownController,
                                errorText: step2EmployerCityDropdownErrorText
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: SearchableDropdown(
                              listItems: step2EmployerRegionDropdownList,
                              addTitle: "Add new Employer region",
                              labelTitle: "Select Employer region *:",
                              hintAddText: "Enter new Employer region",
                              hintSearchText: "Search for a employer region...",
                              dataController: step2EmployerRegionDropdownController,
                              errorText: step2EmployerRegionDropdownErrorText,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: SearchableDropdown(
                              listItems: step2EmployerCountryDropdownList,
                              addTitle: "Add new Employer country",
                              labelTitle: "Select Employer country *:",
                              hintAddText: "Enter new Employer country",
                              hintSearchText: "Search for a employer country...",
                              dataController: step2EmployerCountryDropdownController,
                              errorText: step2EmployerCountryDropdownErrorText,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: CustomTextFormField(title: "Postal Code",  dataType: TextInputType.text,  errorText: step2EmployerPostalCodeErrorText, dataController: step2EmployerPostalCodeController),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: CustomTextFormField(title: "Path To File",  dataType: TextInputType.text,  errorText: step2PathToFileErrorText, dataController: step2PathToFileController),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: CustomTextFormField(title: "Status",  dataType: TextInputType.text,  errorText: step2StatusErrorText, dataController: step2StatusController),
                          ),
                        ),
                        const SizedBox(width: 20,),
                        SizedBox(
                          width: 200,
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: PhoneFormField(title: "Employer Phone", hintText: "Enter The Employer Phone",  errorText: step2EmployerPhoneErrorText, dataController: step2EmployerPhoneController),
                          ),
                        ),

                      ]
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            print("Arrive ICI");
                            print(step2StartDateController.text);
                            print(step2EndDateController.text);
                            print(step2EmploymentTitleController.text);
                            print(step2OccupationController.text);
                            print(step2NumberYearInTheSectorController.text);
                            print(step2AnnualIncomeController.text);
                            print(step2IncomeTypeDropdownController.text);
                            print(step2EmploymentTypeDropdownController.text);
                            print(step2EmployerNameController.text);
                            print(step2EmployerPhoneController.text);
                            print(step2EmployerAddressController.text);
                            print(step2EmployerCityDropdownController.text);
                            print(step2EmployerRegionDropdownController.text);
                            print(step2EmployerCountryDropdownController.text);
                            print(step2PathToFileController.text);
                            print(step2StatusController.text);

                            bool initValueCond = step2StartDateController.text.isNotEmpty &&
                                step2EndDateController.text.isNotEmpty &&
                                step2EmploymentTitleController.text.isNotEmpty &&
                                step2OccupationController.text.isNotEmpty &&
                                step2NumberYearInTheSectorController.text.isNotEmpty &&
                                step2AnnualIncomeController.text.isNotEmpty &&
                                step2IncomeTypeDropdownController.text.isNotEmpty &&
                                step2EmploymentTypeDropdownController.text.isNotEmpty &&
                                step2EmployerNameController.text.isNotEmpty &&
                                step2EmployerPhoneController.text.isNotEmpty &&
                                step2EmployerAddressController.text.isNotEmpty &&
                                step2EmployerCityDropdownController.text.isNotEmpty &&
                                step2EmployerRegionDropdownController.text.isNotEmpty &&
                                step2EmployerCountryDropdownController.text.isNotEmpty &&
                                step2PathToFileController.text.isNotEmpty &&
                                step2StatusController.text.isNotEmpty;





                            if ( initValueCond) {
                              setState(() {
                                employments.add(Employment(
                                    startDate: step2StartDateController.text.trim(),
                                    endDate: step2StartDateController.text.trim(),
                                    title: step2EmploymentTitleController.text.trim(),
                                    occupation: step2OccupationController.text.trim(),
                                    numberYearInTheSector: step2NumberYearInTheSectorController.text.trim(),
                                    annualIncome: step2AnnualIncomeController.text.trim(),
                                    incomeType: step2IncomeTypeDropdownController.text.trim(),
                                    employmentType: step2EmploymentTypeDropdownController.text.trim(),
                                    employerName: step2EmployerNameController.text.trim(),
                                    employerPhone: step2EmployerPhoneController.text.trim(),
                                    employerAddress: step2EmployerAddressController.text.trim(),
                                    employerPostalCode: step2EmployerPostalCodeController.text.trim(),
                                    employerCity: step2EmployerCityDropdownController.text.trim(),
                                    employerRegion: step2EmployerRegionDropdownController.text.trim(),
                                    employerCountry: step2EmployerCountryDropdownController.text.trim(),
                                    status: step2StatusController.text.trim(),
                                    pathToFile: step2PathToFileController.text.trim()
                                ));
                                step2StartDateController.text = '';
                                step2EndDateController.text = '';
                                step2EmploymentTitleController.text = '';
                                step2OccupationController.text = '';
                                step2NumberYearInTheSectorController.text = '';
                                step2AnnualIncomeController.text = '';
                                step2IncomeTypeDropdownController.text = '';
                                step2EmploymentTypeDropdownController.text = '';
                                step2EmploymentTitleController.text = '';
                                step2EmployerNameController.text = '';
                                step2EmployerPhoneController.text = '';
                                step2EmployerAddressController.text = '';
                                step2EmployerCityDropdownController.text = '';
                                step2EmployerRegionDropdownController.text = '';
                                step2EmployerCountryDropdownController.text = '';
                                step2EmployerPostalCodeController.text = '';
                                step2PathToFileController.text = '';
                                step2StatusController.text = '';
                              });
                            }
                          },
                          child: const Text('Save')),
                      ElevatedButton(
                          onPressed: () {
                            bool initValueCond = step2StartDateController.text.isNotEmpty &&
                                step2EndDateController.text.isNotEmpty &&
                                step2EmploymentTitleController.text.isNotEmpty &&
                                step2OccupationController.text.isNotEmpty &&
                                step2NumberYearInTheSectorController.text.isNotEmpty &&
                                step2AnnualIncomeController.text.isNotEmpty &&
                                step2IncomeTypeDropdownController.text.isNotEmpty &&
                                step2EmploymentTypeDropdownController.text.isNotEmpty &&
                                step2EmployerNameController.text.isNotEmpty &&
                                step2EmployerPhoneController.text.isNotEmpty &&
                                step2EmployerAddressController.text.isNotEmpty &&
                                step2EmployerCityDropdownController.text.isNotEmpty &&
                                step2EmployerRegionDropdownController.text.isNotEmpty &&
                                step2EmployerCountryDropdownController.text.isNotEmpty &&
                                step2PathToFileController.text.isNotEmpty &&
                                step2StatusController.text.isNotEmpty;

                            if ( initValueCond) {
                              setState(() {

                                employments[selectedIndex].startDate = step2StartDateController.text.trim();
                                employments[selectedIndex].endDate = step2StartDateController.text.trim();
                                employments[selectedIndex].title = step2EmploymentTitleController.text.trim();
                                employments[selectedIndex].occupation = step2OccupationController.text.trim();
                                employments[selectedIndex].numberYearInTheSector = step2NumberYearInTheSectorController.text.trim();
                                employments[selectedIndex].annualIncome = step2AnnualIncomeController.text.trim();
                                employments[selectedIndex].incomeType = step2IncomeTypeDropdownController.text.trim();
                                employments[selectedIndex].employmentType = step2EmploymentTypeDropdownController.text.trim();
                                employments[selectedIndex].employerName = step2EmployerNameController.text.trim();
                                employments[selectedIndex].employerPhone = step2EmployerPhoneController.text.trim();
                                employments[selectedIndex].employerAddress = step2EmployerAddressController.text.trim();
                                employments[selectedIndex].employerPostalCode = step2EmployerPostalCodeController.text.trim();
                                employments[selectedIndex].employerCity = step2EmployerCityDropdownController.text.trim();
                                employments[selectedIndex].employerRegion = step2EmployerRegionDropdownController.text.trim();
                                employments[selectedIndex].employerCountry = step2EmployerCountryDropdownController.text.trim();
                                employments[selectedIndex].status = step2StatusController.text.trim();
                                employments[selectedIndex].pathToFile = step2PathToFileController.text.trim();
                                selectedIndex = -1;
                                step2StartDateController.text = '';
                                step2EndDateController.text = '';
                                step2EmploymentTitleController.text = '';
                                step2OccupationController.text = '';
                                step2NumberYearInTheSectorController.text = '';
                                step2AnnualIncomeController.text = '';
                                step2IncomeTypeDropdownController.text = '';
                                step2EmploymentTypeDropdownController.text = '';
                                step2EmploymentTitleController.text = '';
                                step2EmployerNameController.text = '';
                                step2EmployerPhoneController.text = '';
                                step2EmployerAddressController.text = '';
                                step2EmployerCityDropdownController.text = '';
                                step2EmployerRegionDropdownController.text = '';
                                step2EmployerCountryDropdownController.text = '';
                                step2EmployerPostalCodeController.text = '';
                                step2PathToFileController.text = '';
                                step2StatusController.text = '';
                              });
                            }
                          },
                          child: const Text('Update')),
                    ],
                  ),
                  const SizedBox(height: 20),
                  employments.isEmpty
                      ? const SizedBox(
                    width: 200,
                    child: Text(
                      'No Employment yet..',
                      style: TextStyle(fontSize: 15),
                    ),
                  )
                      : SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: employments.length,
                          itemBuilder: (context, index) => getRow(index),
                        ),
                      ],
                    ),
                  ),
                ])
        )
    ),
    Step(
        state: currentStep > 2 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 2,
        title: const Text("Actifs & Passifs"),
        content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                children: [
                  ResponsiveForm.responsiveForm(
                      children: [
                        SizedBox(
                          width: 200,
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: SearchableDropdown(
                              listItems: step3ActifTypeDropdownList,
                              addTitle: "Add new Actif Type",
                              labelTitle: "Select Actif Type *:",
                              hintAddText: "Enter new Actif Type",
                              hintSearchText: "Search for a actif type...",
                              dataController: step3ActifTypeDropdownController,
                              errorText: step3ActifTypeDropdownErrorText,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: Padding(
                            padding:  const EdgeInsets.all(0.0),
                            child: CustomTextFormField(title: "Actif Name", dataType: TextInputType.text, errorText: step3ActifNameErrorText, dataController: step3ActifNameController),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: CustomTextFormField(title: "Actif Description", dataType: TextInputType.text, errorText: step3ActifDescriptionErrorText, dataController: step3ActifDescriptionController),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: CustomTextFormField(title: "Actif Current Value", dataType: TextInputType.number, errorText: step3ActifCurrentValueErrorText, dataController: step3ActifCurrentValueController),
                          ),
                        ),

                      ]
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () {

                            bool initValueCond = step3ActifTypeDropdownController.text.isNotEmpty &&
                                step3ActifNameController.text.isNotEmpty &&
                                step3ActifDescriptionController.text.isNotEmpty &&
                                step3ActifCurrentValueController.text.isNotEmpty;



                            if ( initValueCond) {
                              setState(() {
                                actifs.add(Actif(
                                    type: step3ActifTypeDropdownController.text.trim(),
                                    name: step3ActifNameController.text.trim(),
                                    description: step3ActifDescriptionController.text.trim(),
                                    currentValue: step3ActifDescriptionController.text.trim()
                                ));
                                step3ActifTypeDropdownController.text = '';
                                step3ActifNameController.text = '';
                                step3ActifDescriptionController.text = '';
                                step2OccupationController.text = '';
                                step3ActifCurrentValueController.text = '';
                              });
                            }
                          },
                          child: const Text('Save')),
                      ElevatedButton(
                          onPressed: () {
                            bool initValueCond = step3ActifTypeDropdownController.text.isNotEmpty &&
                                step3ActifNameController.text.isNotEmpty &&
                                step3ActifDescriptionController.text.isNotEmpty &&
                                step3ActifCurrentValueController.text.isNotEmpty;

                            if ( initValueCond) {
                              setState(() {

                                actifs[selectedIndex].type = step3ActifTypeDropdownController.text.trim();
                                actifs[selectedIndex].name = step3ActifNameController.text.trim();
                                actifs[selectedIndex].description = step3ActifDescriptionController.text.trim();
                                actifs[selectedIndex].currentValue = step3ActifCurrentValueController.text.trim();
                                selectedIndex = -1;
                                step3ActifTypeDropdownController.text = '';
                                step3ActifNameController.text = '';
                                step3ActifDescriptionController.text = '';
                                step2OccupationController.text = '';
                                step3ActifCurrentValueController.text = '';
                              });
                            }
                          },
                          child: const Text('Update')),
                    ],
                  ),
                  const SizedBox(height: 20),
                  actifs.isEmpty
                      ? const SizedBox(
                    width: 200,
                    child: Text(
                      'No Actifs & Passifs yet..',
                      style: TextStyle(fontSize: 15),
                    ),
                  )
                      : SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: actifs.length,
                          itemBuilder: (context, index) => getRowActif(index),
                        ),
                      ],
                    ),
                  ),
                ])
        )
    ),
    Step(
        state: currentStep > 3 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 3,
        title: const Text("Having Properties"),
        content: ResponsiveForm.responsiveForm(
            children: [
              const SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),
              const SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),
              const SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),
              const SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),
              const SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),
              const SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),
              const SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),
              const SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),
              const SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),
              const SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),
              const SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),
              const SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),
              const SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),
              const SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),

            ]
        )
    ),
    Step(
        state: currentStep > 4 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 4,
        title: const Text("Desaha Properties"),
        content: ResponsiveForm.responsiveForm(
            children: [
              SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),
              const SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),
              const SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),
              const SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),
              const SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),
              const SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),
              const SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),
              const SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),
              const SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),
              const SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),
              const SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),
              const SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),
              const SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),
              const SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),

            ]
        )
    ),
    Step(
        state: currentStep > 5 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 5,
        title: const Text("Hypotheque"),
        content: ResponsiveForm.responsiveForm(
            children: [
              const SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),
              const SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),
              const SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),
              const SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),
              const SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),
              const SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),
              const SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),
              const SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),
              const SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),
              const SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),
              const SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),
              const SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),
              const SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),
              const SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),

            ]
        )
    ),
    Step(
        isActive: currentStep >= 6,
        title: const Text("Documents"),
        content: ResponsiveForm.responsiveForm(
            children: [
              const SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),
              const SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),
              const SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),
              const SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),
              const SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),
              const SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),
              const SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),
              const SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),
              const SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),
              const SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),
              const SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),
              const SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),
              const SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),
              const SizedBox(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: TextField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ),

            ]
        )
    ),
  ];

  Widget getRow(int index) {
    return Card(
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              employments[index].title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(employments[index].occupation),
          ],
        ),
        trailing: SizedBox(
          width: 70,
          child: Row(
            children: [
              InkWell(
                  onTap: () {
                    setState(() {
                      // nameController.text = employments[index].name;
                      // contactController.text = employments[index].contact;
                      selectedIndex = index;
                    });
                  },
                  child: const Icon(Icons.edit)),
              InkWell(
                  onTap: (() {
                    setState(() {
                      employments.removeAt(index);
                    });
                  }),
                  child: const Icon(Icons.delete)),
            ],
          ),
        ),
      ),
    );
  }

  Widget getRowActif(int index) {
    return Card(
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              actifs[index].name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(actifs[index].currentValue),
          ],
        ),
        trailing: SizedBox(
          width: 70,
          child: Row(
            children: [
              InkWell(
                  onTap: () {
                    setState(() {
                      step3ActifTypeDropdownController.text = actifs[index].type;
                      step3ActifNameController.text = actifs[index].name;
                      step3ActifDescriptionController.text = actifs[index].description;
                      step3ActifCurrentValueController.text = actifs[index].currentValue;
                      selectedIndex = index;
                    });
                  },
                  child: const Icon(Icons.edit)),
              InkWell(
                  onTap: (() {
                    setState(() {
                      actifs.removeAt(index);
                    });
                  }),
                  child: const Icon(Icons.delete)),
            ],
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: _drawerKey,
      drawer: const SizedBox(width: 100, child: SideMenu()),
      endDrawer: SizedBox(width: 300, child: Container(
        width: double.infinity,
        height: SizeConfig.screenHeight,
        decoration: const BoxDecoration(color: AppColors.secondaryBg),
        child: const SingleChildScrollView(
          padding:EdgeInsets.symmetric(vertical: 30, horizontal: 30),
          child: Column(
            children: [
              PaymentDetailList(),
            ],
          ),
        ),
      ),),
      appBar: !Responsive.isDesktop(context)
          ? AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        leading: IconButton(
            onPressed: () {
              _drawerKey.currentState?.openDrawer();
            },
            icon: const Icon(Icons.menu, color: AppColors.black)),
        actions: [
          const AppBarActionItems(),
          IconButton(
              onPressed: () {
                _drawerKey.currentState?.openEndDrawer();
              },
              icon:const Icon(Icons.more_vert, color: AppColors.black)
          )
        ],
      )
          : const PreferredSize(
        preferredSize: Size.zero,
        child: SizedBox(),
      ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              const Expanded(
                flex: 1,
                child: SideMenu(),
              ),
            Expanded(
                flex: 10,
                child: SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Header(mainTitle: 'Investors', subTitle: 'Profile Form'),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical! * 4,
                        ),
                        Stepper(
                          type:  StepperType.vertical,
                          steps: getSteps(),
                          currentStep: currentStep,
                          onStepContinue: () {
                            final isLastStep  = ((currentStep) == (getSteps().length - 1));
                            if(isLastStep)
                            {
                              print("complete");
                            }
                            else{
                              setState(() {
                                currentStep += 1;
                              });
                            }

                          },
                          onStepCancel: currentStep == 0 ? null : () => setState(() {currentStep -= 1;}),
                          controlsBuilder: (BuildContext context, ControlsDetails details) {
                            return Container(
                              margin: const EdgeInsets.only(top: 50),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: ElevatedButton(
                                        onPressed: details.onStepContinue,
                                        child: const Text('NEXT'),
                                      )
                                  ),
                                  const SizedBox(width: 12),
                                  if(currentStep != 0)
                                    Expanded(
                                        child: ElevatedButton(
                                          onPressed: details.onStepCancel,
                                          child: const Text('RETURN'),
                                        )
                                    ),
                                ],
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                )),
            if (Responsive.isDesktop(context))
              Expanded(
                flex: 4,
                child: SafeArea(
                  child: Container(
                    width: double.infinity,
                    height: SizeConfig.screenHeight,
                    decoration: const BoxDecoration(color: AppColors.secondaryBg),
                    child: const SingleChildScrollView(
                      padding:EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                      child: Column(
                        children: [
                          AppBarActionItems(),
                          PaymentDetailList()

                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: const AiFloatingActionButton(),
    );
  }


}








