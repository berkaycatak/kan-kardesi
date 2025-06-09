import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:kan_kardesi/models/blood/blood_type_model.dart';
import 'package:kan_kardesi/models/location/city_model.dart';
import 'package:kan_kardesi/screens/search/search_mixin.dart';
import 'package:kan_kardesi/style/theme/custom_theme.dart';
import 'package:kan_kardesi/utils/components/app/custom_appbar_widget.dart';
import 'package:kan_kardesi/utils/components/selector/blood/blood_selector_widget.dart';
import 'package:kan_kardesi/utils/components/selector/city/city_selector_widget.dart';
import 'package:kan_kardesi/utils/components/selector/input_selector_widget.dart';
import 'package:kan_kardesi/utils/enums/reponse_status_enums.dart';
import 'package:kan_kardesi/utils/helpers/helpers.dart';
import 'package:kan_kardesi/utils/widgets/search/search_widget.dart';
import 'package:kan_kardesi/view_models/donation/donation_view_model.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:pull_down_button/pull_down_button.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with SearchMixin {
  @override
  void initState() {
    init(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DonationViewModel donationViewModel =
        Provider.of<DonationViewModel>(context);

    return PlatformScaffold(
      iosContentPadding: true,
      backgroundColor: const Color.fromRGBO(238, 238, 243, 1),
      appBar: customAppBar(context, title: "Ara", canPop: false),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ListView(
          padding: CustomTheme.screenPadding,
          children: [
            SearchCardWidget(
              title: "Bağış İhtiyacı Ara",
              subtitle: "Kan verebileceğiniz ilanları görüntüleyebilirsiniz.",
              color: CustomTheme.primaryColor,
              foregroundColor: Colors.white,
              icon: context.platformIcons.search,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Card(
                    child: CitySelectorWidget(
                      selectedCity: selectedCity,
                      textStyle: TextStyle(
                        fontSize: Platform.isIOS
                            ? Theme.of(context).textTheme.titleMedium?.fontSize
                            : 14,
                        fontWeight: Platform.isAndroid ? FontWeight.w500 : null,
                        color: Platform.isIOS ? Colors.black87 : Colors.black45,
                      ),
                      onSelected: (CityModel city) {
                        selectedCity = city;
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Card(
                    child: BloodSelectorWidget(
                      selectedBloodType: selectedBloodType,
                      textStyle: TextStyle(
                        fontSize: Platform.isIOS
                            ? Theme.of(context).textTheme.titleMedium?.fontSize
                            : 14,
                        fontWeight: Platform.isAndroid ? FontWeight.w500 : null,
                        color: Platform.isIOS ? Colors.black87 : Colors.black45,
                      ),
                      onSelected: (BloodTypeModel type) {
                        selectedBloodType = type;
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                    ),
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    child: PlatformElevatedButton(
                      onPressed: donationViewModel.currentSearchStatus ==
                              ResponseStatus.loading
                          ? null
                          : () {
                              search(context);
                            },
                      child: donationViewModel.currentSearchStatus ==
                              ResponseStatus.loading
                          ? CircularProgressIndicator.adaptive()
                          : const Text("İlan Ara"),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            SearchCardWidget(
              title: "Bağış İhtiyacı Duyur",
              color: CustomTheme.secondaryColor,
              foregroundColor: Colors.white,
              icon: Icons.campaign,
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    Card(
                      child: CitySelectorWidget(
                        selectedCity: selectedCityShare,
                        textStyle: TextStyle(
                          fontSize: Platform.isIOS
                              ? Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.fontSize
                              : 14,
                          fontWeight:
                              Platform.isAndroid ? FontWeight.w500 : null,
                          color: Platform.isIOS
                              ? CupertinoColors.tertiaryLabel
                              : Colors.black45,
                        ),
                        onSelected: (CityModel city) {
                          selectedCityShare = city;
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Card(
                      child: BloodSelectorWidget(
                        selectedBloodType: selectedBloodTypeShare,
                        textStyle: TextStyle(
                          fontSize: Platform.isIOS
                              ? Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.fontSize
                              : 14,
                          fontWeight:
                              Platform.isAndroid ? FontWeight.w500 : null,
                          color:
                              Platform.isIOS ? Colors.black87 : Colors.black45,
                        ),
                        onSelected: (BloodTypeModel type) {
                          selectedBloodTypeShare = type;
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: selectorDecoration(),
                      child: PlatformTextFormField(
                        controller: unitController,
                        hintText: "Ünite",
                        validator: (value) => Helpers.isEmpty(
                          value,
                          "Lütfen kaç üniteye ihtiyaç olduğunu girin.",
                        ),
                        cupertino: (context, platform) =>
                            CupertinoTextFormFieldData(
                          placeholderStyle: const TextStyle(
                            fontFamily: "",
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: selectorDecoration(),
                      child: PlatformTextFormField(
                        controller: descriptionController,
                        hintText: "Açıklama Girin (Opsiyonel)",
                        minLines: 1,
                        maxLines: 3,
                        cupertino: (context, platform) =>
                            CupertinoTextFormFieldData(
                          placeholderStyle: const TextStyle(
                            fontFamily: "",
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: PlatformElevatedButton(
                        color: CustomTheme.secondaryColor,
                        onPressed: donationViewModel.currentShareStatus ==
                                ResponseStatus.loading
                            ? null
                            : () {
                                share(context);
                              },
                        child: donationViewModel.currentShareStatus ==
                                ResponseStatus.loading
                            ? CircularProgressIndicator.adaptive()
                            : const Text("İhtiyaç Duyur"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  PullDownButton iosCitySelector() {
    return PullDownButton(
      menuOffset: 1,
      useRootNavigator: true,
      itemBuilder: (context) => [
        for (var i = 0; i < 100; i++)
          PullDownMenuItem(
            title: 'İstanbul',
            onTap: () {},
          ),
      ],
      buttonBuilder: (context, showMenu) => inputSelector(
        title: "Şehir Seçiniz",
        onPressed: showMenu,
      ),
    );
  }

  Widget androidCitySelector() {
    return inputSelector(
      title: "Şehir Seçiniz",
      onPressed: () {
        return showBarModalBottomSheet(
          useRootNavigator: true,
          context: context,
          builder: (context) {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 1.5,
              child: ListView.builder(
                itemCount: 100,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: const Text("İstanbul"),
                    onTap: () {
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
  }
}
