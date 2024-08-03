import 'package:flutter/material.dart';
import 'package:ice_d/theme.dart';
import 'package:flutter/services.dart';

//ignore: must_be_immutable
class FormFieldToggle extends StatefulWidget {
  String sex;
  final Function onErrorChanged;

  FormFieldToggle({super.key, required this.sex, required this.onErrorChanged});

  @override
  State<FormFieldToggle> createState() => _FormFieldToggleState();
}

class _FormFieldToggleState extends State<FormFieldToggle> {
  List<bool> isSelected = [false, false];
  List<String> sexes = ['남성', '여성'];


  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return FormField(
        initialValue: false,
        validator: (value){
          if (!isSelected.contains(true)){
            widget.onErrorChanged('성별을 선택하세요');
            return '성별을 선택하세요';
          }
          widget.onErrorChanged('');
          return null;
        },
        //autovalidateMode: AutovalidateMode.onUserInteraction,
        builder: (FormFieldState<bool> field){
          return ToggleButtons(
              renderBorder: false,
              fillColor: AppColors.white,
              onPressed: (val){
                setState(() {
                  isSelected = [false, false];
                  isSelected[val] = !isSelected[val];
                  widget.sex = sexes[val];
                });
                field.didChange(true);
              },
              isSelected: isSelected,
              children: List<Widget>.generate(
                  2,
                      (index) => Padding(
                    padding: EdgeInsets.only(right: deviceWidth*0.03),
                    child: Container(
                      width: deviceWidth*0.22,
                      height: 46,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.black, width: 2),
                          borderRadius: BorderRadius.circular(16),
                          color: isSelected[index]? AppColors.accentColor : AppColors.white
                      ),
                      alignment: Alignment.center,
                      child: TextMedium(string: sexes[index], size: 16,),
                    ),
                  )
              )
          );
        }
    );
  }
}

//todo initial value 저장된 값으로 보이게
// todo ㄴ local save 기능
//ignore: must_be_immutable
class FormFieldText extends StatefulWidget {
  late double value;
  final String label;
  final Function onErrorChanged;

  FormFieldText({super.key, required this.value, required this.label, required this.onErrorChanged});

  @override
  State<FormFieldText> createState() => _FormFieldTextState();
}

class _FormFieldTextState extends State<FormFieldText> {

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return FormField<double>(
      initialValue: widget.value,
      validator: (value) {
        if (value == null || value <= 0) {
          widget.onErrorChanged('${widget.label}을(를) 알맞게 입력하세요');
          return '';
        }
        widget.onErrorChanged('');
        return null;
      },
      //Mode: AutovalidateMode.onUserInteraction,
      builder: (FormFieldState<double> field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: deviceWidth * 0.22,
              height: 46,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.black, width: 2),
                borderRadius: BorderRadius.circular(16),
                color: AppColors.white,
              ),
              alignment: Alignment.center,
              child: TextField(
                decoration: const InputDecoration(border: InputBorder.none),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                textAlign: TextAlign.center,
                onChanged: (value) {
                  final parsedValue = double.tryParse(value) ?? 0;
                  field.didChange(parsedValue);
                  widget.value = parsedValue;
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

//todo text vertical center
class FormFieldDropdown extends StatelessWidget {
  final List<String> options;
  final String value;
  final void Function(String?) onChanged;
  final double width;


  const FormFieldDropdown({super.key,
    required this.options,
    required this.value,
    required this.onChanged,
    this.width = 0,
  });

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      width: width == 0? deviceWidth*0.22: width,
      height: 46,
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.black, width: 2),
          borderRadius: BorderRadius.circular(16),
          color: AppColors.white
      ),
      alignment: Alignment.center,
      child: FormField<String>(
        //autovalidateMode: AutovalidateMode.onUserInteraction,
        builder: (FormFieldState<String> state) {
          return Column(
            children: [
              DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: value,
                  isDense: true,
                  isExpanded: true,
                  onChanged: (String? newValue) {
                    state.didChange(newValue);
                    onChanged(newValue);
                  },
                  items: options.map((String option) {
                    return DropdownMenuItem<String>(
                      value: option,
                      child: Center(child: Text(option, textAlign: TextAlign.center,)),
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

