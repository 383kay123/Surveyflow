import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:surveyflow/questionnaire.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Homepage',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            print('tapped');
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Questionnaire()),
            );
          },
          child: SizedBox(
            height: 120.0,
            width: 200, // Fixed height in logical pixels
            child: Card(
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Fill the form',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8.0),
                    const Text('Questionnaires'),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
