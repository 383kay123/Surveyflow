import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:surveyflow/fields/dropcheckbox.dart';
import 'package:surveyflow/fields/radiobuttons.dart';
// This implementation provides the logic for the Children of Household survey form
// It handles field visibility, validation, skip patterns, and data consistency

class SurveyLogic {
  // Main form state object to track all responses
  final Map<String, dynamic> formState = {
    'canChildBeSurveyed': null,
    'surveyNotPossibleReasons': <String>[], // Explicitly type as List<String>
    'showSurveyNotPossibleReasons': false,
    'otherReason': '', // Stores user input for "Other reasons"
    'showOtherReasonField': false, // Controls visibility of "Other reasons"
  };

// Update the updateValue method to handle List<String> for surveyNotPossibleReasons
  void updateValue(String fieldName, dynamic value) {
    if (fieldName == 'surveyNotPossibleReasons') {
      formState[fieldName] = List<String>.from(value);
    } else {
      formState[fieldName] = value;
    }
    updateVisibility();
    validateField(fieldName);
  }

  // Form sections visibility tracking
  final Map<String, bool> sectionVisibility = {
    'basicInfo': true,
    'birthInfo': true,
    'householdRelationship': true,
    'parentalInfo': true,
    'educationInfo': true,
    'schoolAttendance': false,
    'nonSchoolReason': false,
    'workActivities': true,
    'lightTasksSection': false,
  };

  // Initialize form with default visibility and validation rules
  void initializeForm() {
    // Set initial visible sections based on form design
    updateVisibility();
  }

  // Main logic for determining field and section visibility
  void updateVisibility() {
    // Child availability logic
    bool childAvailable = formState['canChildBeSurveyed'] == 'Yes';
    sectionVisibility['unavailabilityReasons'] = !childAvailable;

    if (formState['canChildBeSurveyed'] == 'No') {
      // Show the checkbox field for reasons
      formState['showSurveyNotPossibleReasons'] = true;
    } else {
      // Hide and clear selection
      formState['showSurveyNotPossibleReasons'] = false;
      formState['surveyNotPossibleReasons'] = [];
      formState['showOtherReasonField'] = false;
      formState['otherReason'] = '';
    }

    // Proxy respondent logic - only show if child not available
    bool showProxyFields = !childAvailable;
    sectionVisibility['proxyRespondent'] = showProxyFields;

    // Birth certificate logic
    bool hasBirthCertificate = formState['hasBirthCertificate'] == 'Yes';
    sectionVisibility['noBirthCertificateReason'] = !hasBirthCertificate;

    // Birth location logic
    String birthLocation = formState['birthLocation'] ?? '';
    bool bornInAnotherCountry =
        birthLocation == 'No, he was born in another country';
    sectionVisibility['birthCountry'] = bornInAnotherCountry;

    // Relationship logic - only show "other" field if "Other" is selected
    bool showOtherRelationship =
        formState['relationshipToHead'] == 'Other (to specify)';
    sectionVisibility['otherRelationship'] = showOtherRelationship;

    // Non-family living logic
    bool notLivingWithFamily = !['Son/daughter', 'Grandson/granddaughter']
        .contains(formState['relationshipToHead']);
    sectionVisibility['reasonNotWithFamily'] = notLivingWithFamily;

    // Child placement decision logic
    bool showOtherDecisionMaker =
        formState['childPlacementDecider'] == 'Other(specify)';
    sectionVisibility['otherDecisionMaker'] = showOtherDecisionMaker;

    // Parental contact logic
    bool hasParentalContact = formState['parentalContactLastYear'] == 'Yes';
    sectionVisibility['lastParentalContact'] = hasParentalContact;

    // Child accompaniment logic
    bool showOtherAccompaniment = formState['childAccompaniment'] == 'Other';
    sectionVisibility['otherAccompaniment'] = showOtherAccompaniment;

    // Father residence logic
    bool fatherAbroad = formState['fatherResidence'] == 'Abroad';
    sectionVisibility['fatherCountry'] = fatherAbroad;
    bool otherFatherCountry =
        formState['fatherCountry'] == 'Others to be specified';
    sectionVisibility['otherFatherCountry'] = otherFatherCountry;

    // Mother residence logic
    bool motherAbroad = formState['motherResidence'] == 'Abroad';
    sectionVisibility['motherCountry'] = motherAbroad;
    bool otherMotherCountry =
        formState['motherCountry'] == 'Others to be specified';
    sectionVisibility['otherMotherCountry'] = otherMotherCountry;

    // Education enrollment logic
    bool currentlyEnrolled = formState['currentlyEnrolled'] == 'Yes';
    sectionVisibility['schoolInfo'] = currentlyEnrolled;
    sectionVisibility['schoolAttendance'] = currentlyEnrolled;

    // Previous education logic
    bool everBeenToSchool =
        formState['everBeenToSchool'] == 'Yes, they went to school but stopped';
    sectionVisibility['schoolLeavingYear'] = everBeenToSchool;
    sectionVisibility['reasonLeftSchool'] = everBeenToSchool;

    bool neverBeenToSchool =
        formState['everBeenToSchool'] == 'No, they have never been to school';
    sectionVisibility['reasonNeverAttended'] = neverBeenToSchool;

    // Recent school attendance logic
    bool recentSchoolAttendance = formState['attendedLast7Days'] == 'Yes';
    sectionVisibility['missedSchoolDays'] = recentSchoolAttendance;
    sectionVisibility['reasonNoSchoolLast7Days'] = !recentSchoolAttendance;

    // Missed school days logic
    bool missedSchoolDays = formState['missedSchoolDays'] == 'Yes';
    sectionVisibility['reasonMissedSchool'] = missedSchoolDays;

    // Work activities logic
    bool workedInHouse = formState['workedInHouseLast7Days'] == 'Yes';
    bool workedOnCocoaFarm = formState['workedOnCocoaFarmLast7Days'] == 'Yes';
    sectionVisibility['workFrequency'] = workedInHouse || workedOnCocoaFarm;

    // Light tasks section logic
    bool performedLightTasks =
        (formState['lightTasksPerformed'] ?? []).isNotEmpty;
    sectionVisibility['lightTasksSection'] = performedLightTasks;

    // Remuneration logic
    bool receivedRemuneration = formState['receivedRemuneration'] == 'Yes';
    sectionVisibility['remunerationDetails'] = receivedRemuneration;
  }

  // Validate a specific field based on rules
  Map<String, String?> validateField(String fieldName) {
    Map<String, String?> errors = {};

    switch (fieldName) {
      case 'childFirstName':
      case 'childSurname':
        if (formState[fieldName] == null ||
            formState[fieldName].toString().trim().isEmpty) {
          errors[fieldName] = 'This field is required';
        }
        break;

      case 'yearOfBirth':
        int? birthYear = int.tryParse(formState[fieldName]?.toString() ?? '');
        int currentYear = DateTime.now().year;
        if (birthYear == null) {
          errors[fieldName] = 'Please enter a valid year';
        } else if (birthYear < currentYear - 18 || birthYear > currentYear) {
          errors[fieldName] =
              'Birth year must be between ${currentYear - 18} and $currentYear';
        }
        break;

      case 'schoolLeavingYear':
        int? leavingYear = int.tryParse(formState[fieldName]?.toString() ?? '');
        int currentYear = DateTime.now().year;
        if (leavingYear == null) {
          errors[fieldName] = 'Please enter a valid year';
        } else if (leavingYear < currentYear - 15 ||
            leavingYear > currentYear) {
          errors[fieldName] =
              'School leaving year must be between ${currentYear - 15} and $currentYear';
        }
        break;

      case 'lightTaskHoursNonSchoolDays':
        int? hours = int.tryParse(formState[fieldName]?.toString() ?? '');
        if (hours == null) {
          errors[fieldName] = 'Please enter a valid number';
        } else if (hours < 0 || hours > 168) {
          // 24 hours * 7 days = 168 max hours per week
          errors[fieldName] = 'Hours must be between 0 and 168';
        }
        break;
    }

    return errors;
  }

  // Check for inconsistencies in the form data
  List<String> checkDataConsistency() {
    List<String> inconsistencies = [];

    // Check age consistency with educational level
    int? birthYear = int.tryParse(formState['yearOfBirth']?.toString() ?? '');
    int currentYear = DateTime.now().year;
    int age = birthYear != null ? currentYear - birthYear : 0;

    String educationLevel = formState['educationLevel'] ?? '';
    if (age < 5 &&
        educationLevel != 'Not applicable' &&
        educationLevel != 'Pre-school (Kindergarten)') {
      inconsistencies.add('Child\'s age and education level seem inconsistent');
    }

    // Check if child in school matches with education enrollment status
    bool currentlyEnrolled = formState['currentlyEnrolled'] == 'Yes';
    bool attendedLast7Days = formState['attendedLast7Days'] == 'Yes';
    if (currentlyEnrolled &&
        !attendedLast7Days &&
        formState['reasonNoSchoolLast7Days'] == null) {
      inconsistencies.add(
          'Child is enrolled but didn\'t attend school in last 7 days - reason required');
    }

    // Check work hours consistency
    String longestWorkTime = formState['longestLightDutyTimeNonSchool'] ?? '';
    int? totalHours = int.tryParse(
        formState['lightTaskHoursNonSchoolDays']?.toString() ?? '');

    if (longestWorkTime == 'More than 8 hours' &&
        totalHours != null &&
        totalHours < 8) {
      inconsistencies
          .add('Longest work time and total hours reported are inconsistent');
    }

    return inconsistencies;
  }

  // Get calculated fields
  Map<String, dynamic> getCalculatedFields() {
    Map<String, dynamic> calculatedFields = {};

    // Calculate child's age
    int? birthYear = int.tryParse(formState['yearOfBirth']?.toString() ?? '');
    int currentYear = DateTime.now().year;
    calculatedFields['childAge'] =
        birthYear != null ? currentYear - birthYear : null;

    // Calculate status - whether child is at risk based on multiple factors
    bool atRisk = false;

    // Child not in school and under 15
    if (formState['currentlyEnrolled'] == 'No' &&
        calculatedFields['childAge'] != null &&
        calculatedFields['childAge'] < 15) {
      atRisk = true;
    }

    // Child working on cocoa farm
    if (formState['workedOnCocoaFarmLast7Days'] == 'Yes') {
      atRisk = true;
    }

    // Child working long hours
    String longestWorkTime = formState['longestLightDutyTimeNonSchool'] ?? '';
    if (['6-8 hours', 'More than 8 hours'].contains(longestWorkTime)) {
      atRisk = true;
    }

    calculatedFields['childAtRisk'] = atRisk;

    return calculatedFields;
  }

  // Submit form logic - perform final validation before submission
  Map<String, dynamic> prepareSubmission() {
    // Perform all validations
    Map<String, String?> allErrors = {};
    formState.keys.forEach((field) {
      Map<String, String?> fieldErrors = validateField(field);
      allErrors.addAll(fieldErrors);
    });

    // Check consistency
    List<String> inconsistencies = checkDataConsistency();

    // Add calculated fields
    Map<String, dynamic> calculatedFields = getCalculatedFields();

    // Prepare final submission data
    Map<String, dynamic> submissionData = {
      'formData': {...formState},
      'calculatedFields': calculatedFields,
      'validationErrors': allErrors,
      'dataInconsistencies': inconsistencies,
      'isValid': allErrors.isEmpty && inconsistencies.isEmpty,
    };

    return submissionData;
  }
}

// Example implementation of form interaction in Flutter
class ChildrenOfHouseholdPage extends StatefulWidget {
  @override
  _ChildrenOfHouseholdPageState createState() =>
      _ChildrenOfHouseholdPageState();
}

class _ChildrenOfHouseholdPageState extends State<ChildrenOfHouseholdPage> {
  final SurveyLogic surveyLogic = SurveyLogic();

  @override
  void initState() {
    super.initState();
    surveyLogic.initializeForm();
  }

  void onFieldChanged(String fieldName, dynamic value) {
    setState(() {
      surveyLogic.updateValue(fieldName, value);
    });
  }

  List<Widget> _buildQuestionFields(dynamic questions,
      {Map<String, String>? fieldMapping}) {
    List<Widget> fields = [];

    if (questions is List<String>) {
      fields = questions.map((question) {
        String fieldName = fieldMapping?[question] ?? question;
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: QuestionField(
            question: question,
            onChanged: (value) => onFieldChanged(fieldName, value),
          ),
        );
      }).toList();
    } else if (questions is Map<String, String>) {
      fields = questions.entries.map((entry) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: QuestionField(
            question: entry.value,
            onChanged: (value) => onFieldChanged(entry.key, value),
          ),
        );
      }).toList();
    } else if (questions is String) {
      String fieldName = fieldMapping?[questions] ?? questions;
      fields = [
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: QuestionField(
            question: questions,
            onChanged: (value) => onFieldChanged(fieldName, value),
          ),
        ),
      ];
    }

    return fields;
  }

  // Check if a field should be shown based on logic
  bool isFieldVisible(String fieldName) {
    return surveyLogic.sectionVisibility[fieldName] ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Children of the Household'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // Basic header
              Text(
                'CHILDREN OF THE HOUSEHOLD',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500, fontSize: 10),
              ),
              Text(
                'Tableau: CHILDREN OF THE HOUSEHOLD - %ROSTERTITLE%',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600, fontSize: 16),
              ),
              SizedBox(height: 10),

              // Child identification fields
              RadioButtonField(
                question:
                    'Is the child among the list of children declared in the cover to be the farmers children',
                options: ['Yes', 'No'],
                value: surveyLogic.formState['isChildOfFarmer'],
                onChanged: (value) => onFieldChanged('isChildOfFarmer', value),
              ),

              TextFormField(
                decoration: InputDecoration(
                  labelText:
                      'Enter the number attached to the child name in the cover so we can identify the child in question',
                ),
                onChanged: (value) => onFieldChanged('childIdentifier', value),
              ),

              DropdownField(
                question: 'Can the child be surveyed now?',
                options: ['Yes', 'No'],
                value: surveyLogic.formState['canChildBeSurveyed'],
                onChanged: (value) {
                  setState(() {
                    surveyLogic.updateValue('canChildBeSurveyed', value);
                  });
                },
              ),

              if (surveyLogic.formState['showSurveyNotPossibleReasons'] == true)
                CheckboxField(
                  question: 'If not, what are the reasons?',
                  options: [
                    'The child is at school',
                    'The child has gone to work on the cocoa farm',
                    'Child is busy doing homework',
                    'Child works outside the household',
                    'The child is too young',
                    'The child is sick',
                    'The child has travelled',
                    'The child has gone out to play',
                    'Other',
                  ],
                  value:
                      surveyLogic.formState['surveyNotPossibleReasons'] ?? [],
                  onChanged: (selectedOptions) {
                    setState(() {
                      surveyLogic.updateValue(
                          'surveyNotPossibleReasons', selectedOptions);
                      // Show text field when "Other" is selected
                      surveyLogic.formState['showOtherReasonField'] =
                          selectedOptions.contains('Other');
                    });
                  },
                ),

              // Add "Other reasons" field
              if (surveyLogic.formState['showOtherReasonField'])
                ...(_buildQuestionFields(['Other reasons'])),

              // Conditional proxy respondent fields
              if (isFieldVisible('proxyRespondent'))
                DropdownField(
                  question:
                      'Who is answering for the child since he/she is not available?',
                  options: [
                    'The parents or legal guardians',
                    'Another family member of the child',
                    'One of the childs siblings',
                    'Other'
                  ],
                  value: surveyLogic.formState['proxyRespondent'],
                  onChanged: (value) {
                    onFieldChanged('proxyRespondent', value);
                  },
                ),
              SizedBox(
                height: 10,
              ),
              if (surveyLogic.formState['proxyRespondent'] == 'Other')
                ...(_buildQuestionFields(['If other, please specify'])),

              // Add first name field
              ...(_buildQuestionFields(
                  {'childFirstName': "Child's first name"})),

// Add surname field
              ...(_buildQuestionFields({'childSurname': "Child's surname"})),

// Add gender field with dynamic name
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: RadioButtonField(
                  question:
                      'Gender of ${surveyLogic.formState['childFirstName'] ?? ''} ${surveyLogic.formState['childSurname'] ?? ''}',
                  options: ['Boy', 'Girl'],
                  value: surveyLogic.formState['gender'],
                  onChanged: (value) => onFieldChanged('gender', value),
                ),
              ),

              DatePickerField(
                childFirstName: surveyLogic.formState['childFirstName'] ?? '',
                childSurname: surveyLogic.formState['childSurname'] ?? '',
              ),
              SizedBox(
                height: 10,
              ),
              RadioButtonField(
                question:
                    'Does the child ${surveyLogic.formState['childFirstName'] ?? ''} ${surveyLogic.formState['childSurname'] ?? ''} have a birth certificate?',
                options: ['Yes', 'No'],
                value: surveyLogic.formState['hasBirthCertificate'],
                onChanged: (value) =>
                    onFieldChanged('hasBirthCertificate', value),
              ),

              if (surveyLogic.formState['hasBirthCertificate'] == 'No')
                QuestionField(
                  question: 'If No,please specify why',
                  onChanged: (value) =>
                      onFieldChanged('noBirthCertificateReason', value),
                ),

              DropdownCheckboxField(
                question:
                    "Is the child ${surveyLogic.formState['childFirstName']} born in this community?",
                options: [
                  'Yes',
                  'No, he was born in this district but different community within the district',
                  'No, he was born in this region but different district within the region',
                  'No, he was born in another region of Ghana',
                  'No, he was born in another country',
                ],
                singleSelect: true,
                onChanged: (Map<String, bool> selectedOptions) {
                  surveyLogic.updateValue('birthLocation', selectedOptions);

                  // If born in another country is selected, show additional field
                  if (selectedOptions['No, he was born in another country'] ==
                      true) {
                    surveyLogic.updateValue('showBirthCountryField', true);
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              DropdownCheckboxField(
                question:
                    "In which country is the child ${surveyLogic.formState['childFirstName']} born?",
                options: [
                  'Benin',
                  'Burkina Faso',
                  'Ivory Coast',
                  'Mali',
                  'Niger',
                  'Togo',
                  'Other',
                ],
                singleSelect: true,
                onChanged: (selectedOptions) =>
                    surveyLogic.updateValue('birthCountry', selectedOptions),
              ),
              SizedBox(
                height: 10,
              ),
              DropdownCheckboxField(
                question:
                    "Relationship of ${surveyLogic.formState['childFirstName']} to the head of the household ?",
                options: [
                  'Son/daughter',
                  'Brother/sister',
                  'Son-in-law/daughter-in-law',
                  'Grandson/granddaughter',
                  'Niece/nephew',
                  'Cousin',
                  'Child of the worker',
                  'Child of the farm owner(only if the respondent is the caretaker)',
                  'Other (to specify)',
                ],
                singleSelect: true,
                onChanged: (selectedOptions) {
                  surveyLogic.updateValue(
                      'relationshipToHead', selectedOptions);
                },
              ),

              if (surveyLogic.formState['relationshipToHead']
                          ?.containsKey('Other (to specify)') ==
                      true &&
                  surveyLogic.formState['relationshipToHead']
                          ?['Other (to specify)'] ==
                      true)
                QuestionField(
                  question: "Please specify the relationship",
                  onChanged: (value) =>
                      surveyLogic.updateValue('otherRelationship', value),
                ),

              // Continue with other fields and logic...
              // The above pattern would be repeated for all fields in the form,
              // with conditional rendering based on the logic rules

              // Submit button
              ElevatedButton(
                onPressed: () {
                  // Submit the form
                  Map<String, dynamic> submissionResult =
                      surveyLogic.prepareSubmission();
                  if (submissionResult['isValid']) {
                    // Proceed with API submission or next step
                    print('Form is valid, submitting...');
                  } else {
                    // Show validation errors
                    print(
                        'Form has errors: ${submissionResult['validationErrors']}');
                    print(
                        'Data inconsistencies: ${submissionResult['dataInconsistencies']}');
                  }
                },
                child: Text('Submit'),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

// Let's also define the widget components used in the form
// These are simplified versions - you'll need to implement them fully

class CheckboxField extends StatelessWidget {
  final String question;
  final List<String> options;
  final List<dynamic> value; // Changed to List<dynamic>
  final Function(List<String>) onChanged;

  const CheckboxField({
    Key? key,
    required this.question,
    required this.options,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(question),
        ...options.map((option) => CheckboxListTile(
              title: Text(option),
              value: value.contains(option),
              onChanged: (bool? checked) {
                if (checked == true) {
                  if (!value.contains(option)) {
                    onChanged([...value.map((e) => e.toString()), option]);
                  }
                } else {
                  onChanged(value
                      .where((item) => item != option)
                      .map((e) => e.toString())
                      .toList());
                }
              },
            )),
        SizedBox(height: 16),
      ],
    );
  }
}

class DropdownField extends StatelessWidget {
  final String question;
  final List<String> options;
  final String? value;
  final Function(String) onChanged;

  const DropdownField({
    super.key,
    required this.question,
    required this.options,
    this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8), // Adds spacing between question and dropdown
        SizedBox(
          height: 50, // Ensures the dropdown doesn't overlap the question
          child: DropdownButtonFormField<String>(
            value: value,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
            ),
            hint: Text('Select an option'),
            onChanged: (newValue) {
              if (newValue != null) {
                onChanged(newValue);
              }
            },
            items: options.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class QuestionField extends StatelessWidget {
  final String question;
  final Function(String)? onChanged; // Add this line

  const QuestionField({
    super.key,
    required this.question,
    this.onChanged, // Add this line
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 6),
        TextField(
          decoration: InputDecoration(
            filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10.0),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
          ),
          onChanged: onChanged, // Pass the callback to TextField
        ),
      ],
    );
  }
}

class DatePickerField extends StatefulWidget {
  final String childFirstName;
  final String childSurname;

  const DatePickerField({
    super.key,
    required this.childFirstName,
    required this.childSurname,
  });

  @override
  _DatePickerFieldState createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2015),
      firstDate: DateTime(2007),
      lastDate: DateTime(2020),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color(0xFF00754B),
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF00754B),
              onPrimary: Colors.white,
              onSurface: Colors.black54,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF00754B),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String childName = "${widget.childFirstName} ${widget.childSurname}".trim();
    String question = "Year of birth of $childName";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: () => _selectDate(context),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade400),
            ),
            child: Text(
              selectedDate == null
                  ? "Select Date"
                  : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: selectedDate == null
                    ? const Color(0xFF00754B)
                    : Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
