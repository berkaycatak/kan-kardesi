import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kan_kardesi/models/blood/blood_type_model.dart';
import 'package:kan_kardesi/utils/components/selector/input_selector_widget.dart';
import 'package:kan_kardesi/utils/constants/global_variables/global_variables.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pull_down_button/pull_down_button.dart';

class BloodSelectorWidget extends StatefulWidget {
  final void Function(BloodTypeModel) onSelected;
  final BloodTypeModel? selectedBloodType;
  final bool? useDecoration;
  final TextStyle? textStyle;
  const BloodSelectorWidget({
    super.key,
    required this.onSelected,
    this.useDecoration = true,
    this.textStyle,
    this.selectedBloodType,
  });

  @override
  State<BloodSelectorWidget> createState() => _BloodSelectorWidgetState();
}

class _BloodSelectorWidgetState extends State<BloodSelectorWidget> {
  final ValueNotifier<BloodTypeModel?> selectedBloodType =
      ValueNotifier<BloodTypeModel?>(
    null,
  );

  @override
  void initState() {
    if (widget.selectedBloodType != null) {
      selectedBloodType.value = widget.selectedBloodType;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? iosBloodSelector() : androidBloodSelector();
  }

  Widget iosBloodSelector() {
    return ValueListenableBuilder<BloodTypeModel?>(
        valueListenable: selectedBloodType,
        builder: (context, value, _) {
          return PullDownButton(
            menuOffset: 1,
            useRootNavigator: true,
            itemBuilder: (context) => [
              for (BloodTypeModel bloodType in GlobalVariables.bloodTypes)
                PullDownMenuItem(
                  title: bloodType.type!,
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    selectedBloodType.value = bloodType;
                    widget.onSelected(bloodType);
                  },
                ),
            ],
            buttonBuilder: (context, showMenu) => inputSelector(
              textStyle:
                  selectedBloodType.value == null ? widget.textStyle : null,
              useDecoration: widget.useDecoration,
              title: selectedBloodType.value == null
                  ? "Kan grubu seçin"
                  : selectedBloodType.value!.type!,
              onPressed: showMenu,
            ),
          );
        });
  }

  Widget androidBloodSelector() {
    return ValueListenableBuilder<BloodTypeModel?>(
        valueListenable: selectedBloodType,
        builder: (context, value, _) {
          return inputSelector(
            textStyle:
                selectedBloodType.value == null ? widget.textStyle : null,
            useDecoration: widget.useDecoration,
            title: selectedBloodType.value == null
                ? "Kan grubu seçin"
                : selectedBloodType.value!.type!,
            onPressed: () {
              return showBarModalBottomSheet(
                useRootNavigator: true,
                context: context,
                builder: (context) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: ListView.builder(
                      itemCount: GlobalVariables.bloodTypes.length,
                      itemBuilder: (context, index) {
                        BloodTypeModel bloodType =
                            GlobalVariables.bloodTypes[index];
                        return ListTile(
                          title: Text(bloodType.type!),
                          onTap: () {
                            selectedBloodType.value = bloodType;
                            widget.onSelected(bloodType);
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  );
                },
              );
            },
          );
        });
  }
}
