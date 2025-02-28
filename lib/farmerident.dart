import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:surveyflow/fields/datepickerfield.dart';
import 'package:surveyflow/fields/dropdown.dart';
import 'package:surveyflow/fields/gpsfield.dart';
import 'package:surveyflow/fields/radiobuttons.dart';

class Farmerident extends StatelessWidget {
  const Farmerident({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'FARM IDENTIFICATION',
          style: GoogleFonts.poppins(
              fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF006A4E),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      backgroundColor: Colors.grey[100],
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(
              height: 140, // Adjust this height as needed
              child: DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color(0xFF00754B),
                ),
                child: Align(
                  alignment: Alignment.centerLeft, // Align text to the left
                  child: Text(
                    'REVIEW GHA - CLMRS Household profiling - 24-25',
                    style: GoogleFonts.poppins(
                      fontSize: 16, // Reduce font size if needed
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text(
                'COVER',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
              ),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              title: Text(
                'CONSENT AND LOCATION',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
              ),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              title: Text(
                'FARMER IDENTIFICATION',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
              ),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Fill out the survey',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500, fontSize: 16),
                ),
              ),
              const SizedBox(height: 16),

              RadioButtonField(
                question: 'Is the name of the respondent correct?',
                options: [
                  'Yes',
                  'No',
                ],
              ),

              ..._buildQuestionFields([
                'If No, fill in the exact name and surname of the producer?',
              ]),

              RadioButtonField(
                question: 'What is the nationality of the respondent?',
                options: [
                  'Ghanaian',
                  'Non Ghanaian',
                ],
              ),
              DropdownField(
                question: 'If Non Ghanaian, specify the country of origin',
                options: [
                  'Burkina Faso',
                  'Mali',
                  'Guinea',
                  'Ivory Coast',
                  'Liberia',
                  'Togo',
                  'Benin',
                  'Niger',
                  'Nigeria',
                  'Other (to be specified)',
                ],
              ),

              ..._buildQuestionFields([
                'Other to Specify',
              ]),

              RadioButtonField(
                question: 'Is the respondent the owner of the farm?',
                options: [
                  'Yes',
                  'No',
                ],
              ),

              RadioButtonField(
                question: 'Which of these best describes you?',
                options: [
                  'Complete Owner',
                  'Sharecropper',
                  'Owner/Sharecropper',
                ],
              ),

              RadioButtonField(
                question: 'Which of these best describes you?',
                options: [
                  'Caretaker/Manager of the Farm',
                  'Sharecropper',
                ],
              ),

              Text(
                'IDENTIFICATION OF THE OWNER',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500, fontSize: 14),
              ),
              SizedBox(
                height: 16,
              ),
              // Radio button for farmer availability
              RadioButtonField(
                question: 'Select the type of community',
                options: ['Town', 'Village', 'Camp'],
              ),

              ..._buildQuestionFields([
                'If No, fill in the exact name and surname of the producer?',
              ]),

              RadioButtonField(
                question:
                    'Does the farmer reside in the community stated on the cover?',
                options: [
                  'Yes',
                  'No',
                ],
              ),
              // Add QuestionFields
              ..._buildQuestionFields([
                'If No, provide the name of the community the farmer resides in',
              ]),

              RadioButtonField(
                question: 'Is the farmer available?',
                options: [
                  'Yes',
                  'No',
                ],
              ),

              DropdownField(
                question: 'Select the type of community',
                options: [
                  'Non-Resident',
                  'Deceased',
                  'Doesnt work with Touton anymore',
                  'Other',
                ],
              ),

              ..._buildQuestionFields([
                'Other to specify',
                'Who is available to answer for the farmer?',
              ]),

              DropdownField(
                question: 'Select the type of community',
                options: [
                  'Caretaker',
                  'Spouse',
                  'Nobody',
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Farmerident()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00754B),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 70, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Text(
                  'TO CONTINUE ',
                  style: GoogleFonts.inter(fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildQuestionFields(List<String> questions) {
    return questions
        .map((question) => Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: QuestionField(question: question),
            ))
        .toList();
  }
}

class QuestionField extends StatelessWidget {
  final String question;

  const QuestionField({super.key, required this.question});

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
        ),
      ],
    );
  }
}
