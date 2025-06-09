import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kan_kardesi/models/location/city_model.dart';
import 'package:kan_kardesi/utils/components/selector/input_selector_widget.dart';
import 'package:kan_kardesi/utils/constants/global_variables/global_variables.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pull_down_button/pull_down_button.dart';

class CitySelectorWidget extends StatefulWidget {
  final void Function(CityModel) onSelected;
  final CityModel? selectedCity;
  final bool? useDecoration;
  final TextStyle? textStyle;
  const CitySelectorWidget({
    super.key,
    required this.onSelected,
    this.useDecoration = true,
    this.textStyle,
    this.selectedCity,
  });

  @override
  State<CitySelectorWidget> createState() => _CitySelectorWidgetState();
}

class _CitySelectorWidgetState extends State<CitySelectorWidget> {
  final ValueNotifier<CityModel?> selectedCity = ValueNotifier<CityModel?>(
    null,
  );

  @override
  void initState() {
    if (widget.selectedCity != null) {
      selectedCity.value = widget.selectedCity;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? iosBloodSelector() : androidBloodSelector();
  }

  Widget iosBloodSelector() {
    return ValueListenableBuilder<CityModel?>(
        valueListenable: selectedCity,
        builder: (context, value, _) {
          return PullDownButton(
            menuOffset: 1,
            useRootNavigator: true,
            itemBuilder: (context) => [
              for (CityModel city in GlobalVariables.cities)
                PullDownMenuItem(
                  title: city.name!,
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    selectedCity.value = city;
                    widget.onSelected(city);
                  },
                ),
            ],
            buttonBuilder: (context, showMenu) => inputSelector(
              textStyle: selectedCity.value == null ? widget.textStyle : null,
              useDecoration: widget.useDecoration,
              title: selectedCity.value == null
                  ? "Şehir seçin"
                  : selectedCity.value!.name!,
              onPressed: showMenu,
            ),
          );
        });
  }

  Widget androidBloodSelector() {
    return ValueListenableBuilder<CityModel?>(
        valueListenable: selectedCity,
        builder: (context, value, _) {
          return inputSelector(
            textStyle: selectedCity.value == null ? widget.textStyle : null,
            useDecoration: widget.useDecoration,
            title: selectedCity.value == null
                ? "Şehir seçin"
                : selectedCity.value!.name!,
            onPressed: () {
              return showBarModalBottomSheet(
                useRootNavigator: true,
                context: context,
                builder: (context) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: ListView.builder(
                      itemCount: GlobalVariables.cities.length,
                      itemBuilder: (context, index) {
                        CityModel city = GlobalVariables.cities[index];
                        return ListTile(
                          title: Text(city.name!),
                          onTap: () {
                            selectedCity.value = city;
                            widget.onSelected(city);
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
