import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:kan_kardesi/screens/settings/profile/profile_settings_mixin.dart';
import 'package:kan_kardesi/services/router/router_service.dart';

import 'package:kan_kardesi/style/theme/custom_theme.dart';
import 'package:kan_kardesi/utils/components/app/custom_appbar_widget.dart';

import 'package:kan_kardesi/utils/helpers/helpers.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({super.key});

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen>
    with ProfileSettingsMixin {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      iosContentBottomPadding: true,
      iosContentPadding: true,
      backgroundColor: const Color.fromRGBO(238, 238, 243, 1),
      appBar: customAppBar(context, title: 'Profil Ayarları'),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ListView(
          padding: CustomTheme.screenPadding,
          children: [
            formWidget(context),
          ],
        ),
      ),
    );
  }

  Form formWidget(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Ad Soyad",
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Colors.black),
          ),
          const SizedBox(height: 4),
          Card(
            child: PlatformTextFormField(
              controller: nameController,
              focusNode: nameFocusNode,
              keyboardType: TextInputType.name,
              hintText: "Adınızı ve soyadınızı girin.",
              autofillHints: const [AutofillHints.name],
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (value) => phoneNumberFocusNode.requestFocus(),
              validator: (val) => Helpers.isEmpty(
                val,
                "Lütfen ad soyad girin",
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Telefon Numarası",
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Colors.black),
          ),
          const SizedBox(height: 4),
          Card(
            child: PlatformTextFormField(
              controller: phoneNumberController,
              focusNode: phoneNumberFocusNode,
              inputFormatters: [phoneFormatter],
              keyboardType: TextInputType.phone,
              hintText: "Telefon numaranızı girin.",
              autofillHints: const [AutofillHints.telephoneNumber],
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (value) => phoneNumberFocusNode.requestFocus(),
              validator: phoneValidator,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "E-posta",
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Colors.black),
          ),
          const SizedBox(height: 4),
          Card(
            child: PlatformTextFormField(
              controller: emailController,
              focusNode: emailFocusNode,
              keyboardType: TextInputType.emailAddress,
              hintText: "E-posta adresinizi girin.",
              autofillHints: const [AutofillHints.email],
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (value) => passwordFocusNode.requestFocus(),
              validator: (val) => Helpers.isEmpty(
                val,
                "Lütfen e-posta girin",
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: PlatformElevatedButton(
              onPressed: () => updateProfile(context),
              child: const Text("Profili Güncelle"),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: PlatformTextButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                RouterService.goNamed(
                  context: context,
                  route: RouterService.routes.password_settings,
                );
              },
              child: const Text("Parola Ayarları"),
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
