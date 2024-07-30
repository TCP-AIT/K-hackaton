import 'package:app/ui/widgets/form_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SizeInfo extends StatefulWidget {
  const SizeInfo({super.key});

  @override
  State<SizeInfo> createState() => _SizeInfoState();
}

class _SizeInfoState extends State<SizeInfo> {
  String? _selectedSex;
  final controller = TextEditingController();

  Future<void> _loadSizeInfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedSex = prefs.getString('sex');
      controller.text = prefs.getString('weight') ?? '';
    });
  }

  Future<void> _uploadSizeInfo(String sex, String weight) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('sex', sex);
      prefs.setString('weight', weight);
    });
}

  @override
  void initState(){
    super.initState();
    _loadSizeInfo();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                text32w6("I'm  "),
                dropDownBtn(["man", "women"], _selectedSex,
                        (newValue) {
                      setState(() {
                        _selectedSex = newValue;
                      });
                    },
                    size, size.width*0.5, null)
              ],
            ),
            SizedBox(height: size.width*0.2,),
            text32w6("My weight is"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                textFormField(size.width*0.6, size, controller),
                text32w6("  kg")
              ],
            ),
            SizedBox(height: size.width*0.2,),
            OutlinedButton(
              // submit btn
                onPressed: () {
                  _uploadSizeInfo(_selectedSex!, controller.text);
                  Navigator.pop(context);
                },
                style:
                OutlinedButton.styleFrom(backgroundColor: Colors.white),
                child: const Text('Submit')),
          ],
        ),
      ),
    );
  }
}
