import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:kan_kardesi/screens/auth/register/register_mixin.dart';
import 'package:kan_kardesi/style/theme/custom_theme.dart';
import 'package:kan_kardesi/utils/components/app/custom_card_widget.dart';
import 'package:kan_kardesi/utils/constants/image/image_constants.dart';
import 'package:kan_kardesi/utils/helpers/helpers.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with RegisterMixin {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: PlatformScaffold(
        backgroundColor: Colors.white,
        appBar: PlatformAppBar(),
        iosContentPadding: true,
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 1.15,
            child: Padding(
              padding: CustomTheme.screenPadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        ImageConstants.icon,
                        height: 80,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Kayıt Ol",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Bağışçıları görüntülemek ve duyuruda bulunmak için lütfen kayıt olun.",
                      ),
                      const SizedBox(height: 36),
                      formWidget(context),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: PlatformElevatedButton(
                          onPressed: () => register(context),
                          child: const Text("Kayıt Ol"),
                        ),
                      ),
                      // Center(
                      //   child: PlatformTextButton(
                      //     padding: EdgeInsets.zero,
                      //     onPressed: () {},
                      //     child: const Text("Parolamı Unuttum"),
                      //   ),
                      // ),
                      const SizedBox(height: 16),
                    ],
                  )
                ],
              ),
            ),
          ),
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
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 4),
          CustomCard(
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
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 4),
          CustomCard(
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
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 4),
          CustomCard(
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
          const SizedBox(height: 10),
          Text(
            "Parola",
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 4),
          CustomCard(
            child: PlatformTextFormField(
              controller: passwordController,
              focusNode: passwordFocusNode,
              keyboardType: TextInputType.visiblePassword,
              hintText: "Parola girin.",
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
          Text(
            "Parola Tekrar",
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 4),
          CustomCard(
            child: PlatformTextFormField(
              controller: rePasswordController,
              focusNode: rePasswordFocusNode,
              keyboardType: TextInputType.visiblePassword,
              hintText: "Parolanzı onaylayın.",
              obscureText: true,
              autofillHints: const [AutofillHints.password],
              textInputAction: TextInputAction.send,
              onFieldSubmitted: (value) => register(context),
              validator: (val) => Helpers.isEmpty(
                val,
                "Lütfen parolanızı tekrar girin",
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
