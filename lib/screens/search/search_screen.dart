import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:kan_kardesi/screens/search/search_mixin.dart';
import 'package:kan_kardesi/style/theme/custom_theme.dart';
import 'package:kan_kardesi/utils/components/app/custom_appbar_widget.dart';
import 'package:kan_kardesi/utils/widgets/search/search_widget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pull_down_button/pull_down_button.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with SearchMixin {
  @override
  Widget build(BuildContext context) {
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
              color: CustomTheme.primaryColor,
              foregroundColor: Colors.white,
              icon: context.platformIcons.search,
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  if (Platform.isIOS)
                    iosCitySelector()
                  else
                    androidCitySelector(),
                  const SizedBox(height: 10),
                  if (Platform.isIOS)
                    iosBloodSelector()
                  else
                    androidBloodSelector(),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: PlatformElevatedButton(
                      onPressed: () {},
                      child: const Text("Bağışçı Ara"),
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
              icon: context.platformIcons.search,
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  if (Platform.isIOS)
                    iosCitySelector()
                  else
                    androidCitySelector(),
                  const SizedBox(height: 10),
                  if (Platform.isIOS)
                    iosBloodSelector()
                  else
                    androidBloodSelector(),
                  const SizedBox(height: 10),
                  Container(
                    decoration: selectorDecoration(),
                    child: PlatformTextFormField(
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
                      onPressed: () {},
                      child: const Text("İhtiyaç Duyur"),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  PullDownButton iosBloodSelector() {
    return PullDownButton(
      menuOffset: 1,
      useRootNavigator: true,
      itemBuilder: (context) => [
        for (var i = 0; i < 10; i++)
          PullDownMenuItem(
            title: 'A Rh+',
            onTap: () {},
          ),
      ],
      buttonBuilder: (context, showMenu) => inputSelector(
        title: "Kan grubu seçin",
        onPressed: showMenu,
      ),
    );
  }

  Widget androidBloodSelector() {
    return inputSelector(
      title: "Kan grubu seçin",
      onPressed: () {
        return showBarModalBottomSheet(
          useRootNavigator: true,
          context: context,
          builder: (context) {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 1.5,
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: const Text("A Rh+"),
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

  PlatformTextButton inputSelector({
    required String title,
    required Future<void> Function() onPressed,
  }) {
    return PlatformTextButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: selectorDecoration(),
        child: Row(
          children: [
            Text(
              title,
              style: const TextStyle(color: Colors.black),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.black.withOpacity(.6),
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration selectorDecoration() {
    return BoxDecoration(
      border: Border.all(
        color: const Color.fromRGBO(1, 1, 1, .1),
        width: 1,
      ),
      borderRadius: BorderRadius.circular(4),
    );
  }
}
