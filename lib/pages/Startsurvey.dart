import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:surveyflow/pages/consent.dart';

class SurveyListPage extends StatelessWidget {
  const SurveyListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Example survey data
    final List<Map<String, String>> surveys = [
      {
        'title': 'REVIEW GHA - CLMRS Household Profiling -24 - 25',
        'description': 'Click here to proceed',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Available Surveys',
          style: GoogleFonts.poppins(
              fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF006A4E),
      ),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: surveys.length,
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                title: Text(surveys[index]['title']!,
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                subtitle: Text(surveys[index]['description']!,
                    style: GoogleFonts.poppins(fontSize: 14)),
                trailing:
                    const Icon(Icons.arrow_forward, color: Color(0xFF00754B)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const Consent()), // Navigate to the survey page
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
