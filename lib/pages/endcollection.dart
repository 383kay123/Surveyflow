import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:surveyflow/fields/checkbox.dart';
import 'package:surveyflow/fields/datepickerfield.dart';
import 'package:surveyflow/fields/gpsfield.dart';
import 'package:surveyflow/fields/image_picker.dart';
import 'package:surveyflow/fields/radiobuttons.dart';
import 'package:surveyflow/pages/Consent.dart';
import 'package:surveyflow/pages/cover.dart';
import 'package:surveyflow/pages/farmerident.dart';
import 'package:surveyflow/pages/remediation.dart';
import 'package:surveyflow/pages/sensitization.dart';

class Endcollection extends StatelessWidget {
  const Endcollection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'END OF COLLECTION',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700, color: Colors.white),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
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
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Picture of the respondent',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    PictureField(),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Signature Producer',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    PictureField(),
                    SizedBox(
                      height: 10,
                    ),
                    GPSField(question: 'Provide end gps of survey'),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 10,
                    ),
                    DatePickerField(question: 'Provide end time of survey'),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 10,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      // Add this
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Remediation()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00754B),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: Text(
                          'PREV',
                          style: GoogleFonts.inter(fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Endcollection()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00754B),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: Text(
                          'SUBMIT',
                          style: GoogleFonts.inter(fontWeight: FontWeight.w400),
                        ),
                      ),
                      const SizedBox(height: 50),
                    ]),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}

List<Widget> _buildQuestionFields(List<String> questions) {
  return questions
      .map((question) => Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: QuestionField(question: question),
          ))
      .toList();
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
