import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:kan_kardesi/screens/auth/login/login_mixin.dart';
import 'package:kan_kardesi/style/theme/custom_theme.dart';
import 'package:kan_kardesi/utils/components/app/custom_card_widget.dart';
import 'package:kan_kardesi/utils/constants/image/image_constants.dart';
import 'package:kan_kardesi/utils/helpers/helpers.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with LoginMixin {
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
                        "Giriş Yap",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Bağışçıları görüntülemek ve duyuruda bulunmak için lütfen giriş yapın.",
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
                          onPressed: () => login(context),
                          child: const Text("Giriş Yap"),
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
            "E-posta",
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 4),
          CustomCard(
            child: PlatformTextFormField(
              controller: emailController,
              focusNode: emailFocusNode,
              keyboardType: TextInputType.emailAddress,
              hintText: "E-posta",
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
              textInputAction: TextInputAction.send,
              onFieldSubmitted: (value) => login(context),
              validator: (val) => Helpers.isEmpty(
                val,
                "Lütfen parola girin",
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
