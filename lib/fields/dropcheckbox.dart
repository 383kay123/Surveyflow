import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DropdownCheckboxField extends StatefulWidget {
  final String question;
  final List<String> options;
  final Function(Map<String, bool>) onChanged;
  final bool singleSelect;

  const DropdownCheckboxField({
    super.key,
    required this.question,
    required this.options,
    required this.onChanged,
    this.singleSelect = false,
  });

  @override
  _DropdownCheckboxFieldState createState() => _DropdownCheckboxFieldState();
}

class _DropdownCheckboxFieldState extends State<DropdownCheckboxField> {
  Map<String, bool> selectedOptions = {};
  bool isDropdownOpen = false;

  @override
  void initState() {
    super.initState();
    for (var option in widget.options) {
      selectedOptions[option] = false;
    }
  }

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
        GestureDetector(
          onTap: () {
            setState(() {
              isDropdownOpen = !isDropdownOpen;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    selectedOptions.entries
                        .where((entry) => entry.value)
                        .map((entry) => entry.key)
                        .join(', '),
                    semanticsLabel: 'Select options',
                    style: GoogleFonts.poppins(fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                Icon(
                  isDropdownOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                ),
              ],
            ),
          ),
        ),
        if (isDropdownOpen)
          Container(
            margin: const EdgeInsets.only(top: 5),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.options.map((option) {
                return CheckboxListTile(
                  title: Text(option, style: GoogleFonts.poppins(fontSize: 14)),
                  value: selectedOptions[option] ?? false,
                  onChanged: (bool? value) {
                    if (widget.singleSelect) {
                      if (selectedOptions[option] == true) {
                        selectedOptions[option] = false;
                      } else {
                        selectedOptions.forEach((key, _) {
                          selectedOptions[key] = false;
                        });
                        selectedOptions[option] = true;
                      }
                    } else {
                      selectedOptions[option] = value ?? false;
                    }

                    setState(() {});
                    widget.onChanged(Map<String, bool>.from(selectedOptions));
                  },
                  activeColor: const Color(0xFF00754B),
                  controlAffinity: ListTileControlAffinity.leading,
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}
