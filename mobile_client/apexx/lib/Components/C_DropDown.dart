import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class CDropDown extends StatefulWidget {
  late List<String> items;
  late String selected;
  CDropDown(
    this.items, {
    super.key,
    this.selected = "",
  });

  @override
  State<CDropDown> createState() => _CDropDownState();
}

class _CDropDownState extends State<CDropDown> {
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: double.infinity,
      // padding: EdgeInsets.all(14),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: true,
          hint: const Text(
            'Select',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          items: widget.items
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
              .toList(),
          value: selectedValue,
          onChanged: (value) {
            setState(() {
              selectedValue = value as String;
              widget.selected = value;
            });
          },
          buttonStyleData: ButtonStyleData(
            height: 50,
            width: 160,
            padding: const EdgeInsets.only(left: 14, right: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: const Color(0xff4A576F),
            ),
            elevation: 2,
          ),
          iconStyleData: const IconStyleData(
            icon: Icon(
              Icons.arrow_drop_down,
              size: 30,
              color: Colors.white,
            ),
            iconSize: 14,
            iconDisabledColor: Colors.grey,
          ),
          dropdownStyleData: DropdownStyleData(
              maxHeight: 200,
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: const Color(0xff4A576F),
              ),
              elevation: 8,
              offset: const Offset(-20, 0),
              scrollbarTheme: ScrollbarThemeData(
                radius: const Radius.circular(40),
                thickness: MaterialStateProperty.all(6),
                thumbVisibility: MaterialStateProperty.all(true),
              )),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
            padding: EdgeInsets.only(left: 14, right: 14),
          ),
        ),
      ),
    );
  }
}