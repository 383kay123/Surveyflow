import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:surveyflow/pages/cover.dart';
import 'package:surveyflow/pages/endcollection.dart';
import 'package:surveyflow/pages/farmerident.dart';
import 'package:surveyflow/fields/datepickerfield.dart';
import 'package:surveyflow/fields/dropdown.dart';
import 'package:surveyflow/fields/gpsfield.dart';
import 'package:surveyflow/fields/radiobuttons.dart';
import 'package:surveyflow/pages/remediation.dart';
import 'package:surveyflow/pages/sensitization.dart';

class Consent extends StatelessWidget {
  const Consent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CONSENT AND LOCATION',
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
        actions: [
          IconButton(
            icon: const Icon(Icons.sync,
                color: Colors.white), // Change the icon here
            onPressed: () {
              // Add functionality here
            },
          ),
        ],
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
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Questionnaire()),
                );
              },
            ),
            ListTile(
              title: Text(
                'CONSENT AND LOCATION',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Consent()),
                );
              },
            ),
            ListTile(
              title: Text(
                'FARMER IDENTIFICATION',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Farmerident()),
                );
              },
            ),
            ListTile(
              title: Text(
                'REMEDIATION',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Remediation()),
                );
              },
            ),
            ListTile(
              title: Text(
                'SENSITIZATION',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Sensitization()),
                );
              },
            ),
            ListTile(
              title: Text(
                'END OF COLLECTION',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Endcollection()),
                );
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 80), // Space for buttons
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
                  DatePickerField(question: 'Record the interview start time'),
                  const SizedBox(height: 16),
                  GPSField(question: 'GPS point of the household'),
                  const SizedBox(height: 16),
                  RadioButtonField(
                    question: 'Select the type of community',
                    options: ['Town', 'Village', 'Camp'],
                    onChanged: (String) {},
                  ),
                  RadioButtonField(
                    question:
                        'Does the farmer reside in the community stated on the cover?',
                    options: ['Yes', 'No'],
                    onChanged: (String) {},
                  ),
                  _buildQuestionField(
                      'If No, provide the name of the community the farmer resides in'),
                  RadioButtonField(
                    question: 'Is the farmer available?',
                    options: ['Yes', 'No'],
                    onChanged: (String) {},
                  ),
                  DropdownField(
                    question: 'Farmer status',
                    options: [
                      'Non-Resident',
                      'Deceased',
                      'Doesn’t work with Touton anymore',
                      'Other',
                    ],
                  ),
                  _buildQuestionField('Other to specify'),
                  _buildQuestionField('Who is available to answer for farmer?'),
                  DropdownField(
                    question: 'Select respondent',
                    options: ['Caretaker', 'Spouse', 'Nobody'],
                  ),
                  const SizedBox(height: 100), // Extra space for scrolling
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Questionnaire()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00754B),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text('PREV',
                        style: GoogleFonts.inter(fontWeight: FontWeight.w400)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Farmerident()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00754B),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text('NEXT',
                        style: GoogleFonts.inter(fontWeight: FontWeight.w400)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionField(String question) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style:
                GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
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
      ),
    );
  }
}
