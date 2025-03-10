import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:surveyflow/pages/Startsurvey.dart';
import 'package:surveyflow/pages/cover.dart';
import 'package:surveyflow/pages/dynamic.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Homepage',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500, color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
      ),
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
                    'SURVEYFLOW',
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
                'HOME ',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Homepage()),
                );
              },
            ),
            ListTile(
              title: Text(
                'SURVEYS',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SurveyListPage()),
                );
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 cards per row
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.1, // Adjust for better spacing
          ),
          itemCount: 4,
          itemBuilder: (context, index) {
            final List<Map<String, dynamic>> cardData = [
              {
                'title': 'Start Survey',
                'subtitle': 'Select a survey',
                'icon': Icons.assignment,
                'page': const SurveyListPage(),
              },
              {
                'title': 'View Data',
                'subtitle': 'Check survey results',
                'icon': Icons.bar_chart,
                'page': const Questionnaire(),
              },
              {
                'title': 'Survey Preview',
                'subtitle': 'View survey divisions',
                'icon': Icons.favorite,
                'page': const Questionnaire(),
              },
              {
                'title': 'Settings',
                'subtitle': 'Customize app',
                'icon': Icons.settings,
                'page': DynamicSurveyPage(),
              },
            ];

            return _buildCard(
              context,
              cardData[index]['title']!,
              cardData[index]['subtitle']!,
              cardData[index]['icon'] as IconData,
              cardData[index]['page'] as Widget,
            );
          },
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, String subtitle,
      IconData icon, Widget destination) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: const Color(0xFFE3F2FD), // Light blue background
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: 30,
                color: Color(0xFF00754B),
              ), // Icon
              const SizedBox(height: 8),
              Text(title,
                  style: GoogleFonts.poppins(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              const SizedBox(height: 4),
              Text(subtitle,
                  style: GoogleFonts.poppins(
                      fontSize: 14.0, color: Colors.black54)),
            ],
          ),
        ),
      ),
    );
  }
}
