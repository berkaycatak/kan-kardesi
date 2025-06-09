import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:kan_kardesi/screens/profile/profile_mixin.dart';
import 'package:kan_kardesi/services/router/route_constants.dart';
import 'package:kan_kardesi/services/router/router_service.dart';
import 'package:kan_kardesi/style/theme/custom_theme.dart';
import 'package:kan_kardesi/utils/components/app/custom_appbar_widget.dart';
import 'package:kan_kardesi/utils/constants/global_variables/global_variables.dart';
import 'package:kan_kardesi/utils/widgets/requests/blood_requests_list_widget.dart';
import 'package:kan_kardesi/view_models/auth/auth_view_model.dart';
import 'package:kan_kardesi/view_models/user/user_view_model.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with ProfileMixin {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      init(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserViewModel userViewModel = Provider.of<UserViewModel>(context);
    AuthViewModel authViewModel = Provider.of<AuthViewModel>(context);

    return PlatformScaffold(
      iosContentBottomPadding: true,
      iosContentPadding: true,
      backgroundColor: const Color.fromRGBO(238, 238, 243, 1),
      appBar: customAppBar(
        context,
        title: 'Profil',
        canPop: false,
        actions: [
          PlatformIconButton(
            padding: EdgeInsets.zero,
            onPressed: () => logout(context),
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
              size: 24,
            ),
          )
        ],
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: () {
          return getProfile(context);
        },
        child: ListView(
          padding: CustomTheme.screenPadding,
          children: [
            profileDetailWidget(context),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "İhtiyaç Duyurularım",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: 20,
                      ),
                ),
                PlatformIconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    RouterService.goNamed(
                      context: context,
                      route: RouteConstants().search,
                    );
                  },
                  icon: Icon(
                    context.platformIcons.addCircledSolid,
                    color: Colors.red,
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            BloodRequestsListWidget(
              requests: authViewModel.userModel!.requests ?? [],
              emptyText:
                  "İhtiyaç duyurunuz bulunmuyor. ❤️ Sağlıklı günler dileriz.",
            ),
          ],
        ),
      ),
    );
  }

  SizedBox profileDetailWidget(BuildContext context) {
    AuthViewModel authViewModel = Provider.of<AuthViewModel>(context);

    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: CustomTheme.screenPadding,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      authViewModel.userModel!.name!,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "+90 ${authViewModel.userModel!.phone!}",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: PlatformElevatedButton(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Text(
                      "Düzenle",
                    ),
                    onPressed: () {
                      RouterService.goNamed(
                        context: context,
                        route: RouteConstants().profile_settings,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
