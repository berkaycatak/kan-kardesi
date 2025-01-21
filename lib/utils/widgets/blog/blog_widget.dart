import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:kan_kardesi/services/router/route_constants.dart';
import 'package:kan_kardesi/services/router/router_service.dart';
import 'package:kan_kardesi/style/theme/custom_theme.dart';
import 'package:kan_kardesi/utils/constants/image/image_constants.dart';

class BlogWidget extends StatelessWidget {
  const BlogWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PlatformTextButton(
      onPressed: () {
        RouterService.goNamed(
          context: context,
          route: RouteConstants().blog_detail,
        );
      },
      padding: EdgeInsets.zero,
      child: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                ImageConstants.welcome,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    CustomTheme.primaryColor.withOpacity(.1),
                    CustomTheme.primaryColor,
                  ],
                ),
              ),
            ),
            Padding(
              padding: CustomTheme.screenPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Kan Bağışı Yapmanın 5 Faydası!",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                  ),
                  Text(
                    "Düzenli kan bağışı yaparak hem kendi sağlığınızı koruyabilir hem de başkalarına yardım edebilirsiniz.",
                    softWrap: true,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.white,
                          fontSize: 13.5,
                        ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
