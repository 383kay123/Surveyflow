import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RadioButtonField extends StatelessWidget {
  final String question;
  final List<String> options;
  final String? value;
  final Function(String)? onChanged;

  const RadioButtonField({
    Key? key,
    required this.question,
    required this.options,
    this.value,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 16.0,
          runSpacing: 8.0,
          children: options.map((option) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio<String>(
                  value: option,
                  groupValue: value,
                  onChanged: (newValue) {
                    if (newValue != null) {
                      onChanged!(newValue);
                    }
                  },
                  activeColor: const Color(0xFF00754B),
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
