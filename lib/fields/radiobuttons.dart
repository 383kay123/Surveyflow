import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RadioButtonField extends StatefulWidget {
  final String question;
  final List<String> options;

  const RadioButtonField({
    super.key,
    required this.question,
    required this.options,
  });

  @override
  _RadioButtonFieldState createState() => _RadioButtonFieldState();
}

class _RadioButtonFieldState extends State<RadioButtonField> {
  String? selectedOption; // Stores the selected radio button value

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.question,
          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 16.0, // Space between radio button groups
          runSpacing: 8.0, // Space between rows if wrapped
          children: widget.options.map((option) {
            return Row(
              mainAxisSize: MainAxisSize.min, // Prevents unnecessary stretching
              children: [
                Radio<String>(
                  value: option,
                  groupValue: selectedOption,
                  onChanged: (value) {
                    setState(() {
                      selectedOption = value;
                    });
                  },
                  activeColor:
                      const Color(0xFF00754B), // Your app's primary color
                ),
                Text(
                  option,
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
              ],
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
