import 'package:flutter/material.dart';
import 'package:app/theme.dart';
import 'package:flutter/services.dart';

Widget dropDownBtn(List<String> dropdownList, String? selectedValue,
    ValueChanged<String?> onChanged, Size size, double btnWidth, double? btnHeight) {
  return Container(
      decoration: BoxDecoration(
        border: Border.all(color: ColorStyles.sblack, width: 1),
        borderRadius: BorderRadius.circular(32),
      ),
      width: btnWidth,
      height: btnHeight ?? size.width * 0.8 / 6,
      child: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: DropdownButton<String>(
            value: selectedValue,
            items: dropdownList.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Center(child: Text(value, textAlign: TextAlign.center,)),
              );
            }).toList(),
            onChanged: onChanged,
            icon: const Padding(
              padding: EdgeInsets.only(left: 8, right: 4),
              child: Icon(Icons.keyboard_arrow_down),
            ),
            underline: Container(),
            isExpanded: true,
          )
      )
  );
}

Widget textFormField(formWidth, size, controller) {
  return Container(
      decoration: BoxDecoration(
        border: Border.all(color: ColorStyles.sblack, width: 1),
        borderRadius: BorderRadius.circular(32),
      ),
      width: formWidth,
      height: size.width * 0.8 / 6,
      child: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(border: InputBorder.none),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
          )
      )
  );
}
