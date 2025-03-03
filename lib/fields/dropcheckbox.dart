import 'package:flutter/material.dart';

class CheckboxDropdown extends StatefulWidget {
  const CheckboxDropdown({super.key});

  @override
  _CheckboxDropdownState createState() => _CheckboxDropdownState();
}

class _CheckboxDropdownState extends State<CheckboxDropdown> {
  List<String> items = [
    "He/she was sick",
    "He/she was working",
    "He/she traveled",
    "Other"
  ];
  List<String> selectedItems = []; // Stores selected options

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Why has the child not been to school?",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            showMenu(
              context: context,
              position: RelativeRect.fromLTRB(100, 250, 100, 100),
              items: [
                PopupMenuItem(
                  enabled: false, // Disables interaction with the title
                  child: Text("Select reasons",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                ...items.map((String item) {
                  return PopupMenuItem(
                    child: StatefulBuilder(
                      builder: (context, setState) {
                        return CheckboxListTile(
                          title: Text(item),
                          value: selectedItems.contains(item),
                          onChanged: (bool? value) {
                            setState(() {
                              if (value == true) {
                                selectedItems.add(item);
                              } else {
                                selectedItems.remove(item);
                              }
                            });
                          },
                        );
                      },
                    ),
                  );
                }).toList(),
              ],
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              selectedItems.isEmpty
                  ? "Select reasons"
                  : selectedItems.join(", "),
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}
