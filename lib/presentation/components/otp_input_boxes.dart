import 'package:flutter/material.dart';
import 'package:mira_care/constants/app_colors.dart';

const zwsp = '\u200b';

const zwspEditingValue = TextEditingValue(
  text: zwsp,
  selection: TextSelection(baseOffset: 1, extentOffset: 1),
);

class OtpInputBoxes extends StatefulWidget {
  const OtpInputBoxes({
    super.key,
    required this.otpController,
  });

  final TextEditingController otpController;

  @override
  // ignore: library_private_types_in_public_api
  _OtpInputBoxesState createState() => _OtpInputBoxesState();
}

class _OtpInputBoxesState extends State<OtpInputBoxes> {
  List<String> code = ['', '', '', ''];

  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;

  @override
  void initState() {
    super.initState();
    focusNodes = List.generate(4, (index) => FocusNode());
    updateControllers();
  }

  @override
  void dispose() {
    super.dispose();
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    for (var controller in controllers) {
      controller.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        4,
        (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: SizedBox(
              width: 50,
              height: 50,
              child: Container(
                decoration: BoxDecoration(
                  color: appColors.msgPin,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: TextField(
                  style: TextStyle(color: appColors.red),
                  controller: controllers[index],
                  focusNode: focusNodes[index],
                  maxLength: 2,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    counterText: "",
                    contentPadding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.aspectRatio * 45,
                    ),
                  ),
                  onChanged: (value) {
                    if (value.length > 1) {
                      if (index + 1 == focusNodes.length) {
                        FocusScope.of(context).unfocus();
                      } else {
                        focusNodes[index + 1].requestFocus();
                      }
                    } else {
                      controllers[index].value = zwspEditingValue;
                      if (index == 0) {
                      } else {
                        controllers[index - 1].value = zwspEditingValue;
                        focusNodes[index - 1].requestFocus();
                      }
                    }
                    code[index] = value.replaceAll(zwsp, '');
                    widget.otpController.text = code.join();
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void updateControllers() {
    controllers = List.generate(4, (index) {
      final ctrl = TextEditingController();
      ctrl.value = zwspEditingValue;
      return ctrl;
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      focusNodes[0].requestFocus();
    });
  }

  Widget buildCodeNumberBox() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: SizedBox(
        width: 50,
        height: 50,
        child: Container(
          decoration: BoxDecoration(
            color: appColors.white,
            borderRadius: BorderRadius.zero,
          ),
          child: Center(
            child: Text(
              '0',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: appColors.textGray,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
