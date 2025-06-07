import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:kan_kardesi/screens/settings/password/password_settings_mixin.dart';
import 'package:kan_kardesi/style/theme/custom_theme.dart';
import 'package:kan_kardesi/utils/components/app/custom_appbar_widget.dart';
import 'package:kan_kardesi/utils/helpers/helpers.dart';

class PasswordSettingsScreen extends StatefulWidget {
  const PasswordSettingsScreen({super.key});

  @override
  State<PasswordSettingsScreen> createState() => _PasswordSettingsScreenState();
}

class _PasswordSettingsScreenState extends State<PasswordSettingsScreen>
    with PasswordSettingsMixin {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      iosContentPadding: true,
      backgroundColor: const Color.fromRGBO(238, 238, 243, 1),
      appBar: customAppBar(context, title: 'Parola Ayarları'),
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
            "Mevcut Parola",
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Colors.black),
          ),
          const SizedBox(height: 4),
          Card(
            child: PlatformTextFormField(
              controller: oldPasswordController,
              focusNode: oldPasswordFocusNode,
              keyboardType: TextInputType.visiblePassword,
              hintText: "Mevcut parolanızı girin.",
              obscureText: true,
              autofillHints: const [AutofillHints.password],
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (value) => passwordFocusNode.requestFocus(),
              validator: (val) => Helpers.isEmpty(
                val,
                "Lütfen parola girin",
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Yeni Parola",
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Colors.black),
          ),
          const SizedBox(height: 4),
          Card(
            child: PlatformTextFormField(
              controller: passwordController,
              focusNode: passwordFocusNode,
              keyboardType: TextInputType.visiblePassword,
              hintText: "Yeni parolanızı girin.",
              obscureText: true,
              autofillHints: const [AutofillHints.password],
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (value) => rePasswordFocusNode.requestFocus(),
              validator: (val) => Helpers.isEmpty(
                val,
                "Lütfen parola girin",
              ),
            ),
          ),
          const SizedBox(height: 10),
          Card(
            child: PlatformTextFormField(
              controller: rePasswordController,
              focusNode: rePasswordFocusNode,
              keyboardType: TextInputType.visiblePassword,
              hintText: "Parolanzı onaylayın.",
              obscureText: true,
              autofillHints: const [AutofillHints.password],
              textInputAction: TextInputAction.send,
              onFieldSubmitted: (value) => updatePassword(context),
              validator: validatePassword,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: PlatformElevatedButton(
              onPressed: () => updatePassword(context),
              child: const Text("Profili Güncelle"),
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
