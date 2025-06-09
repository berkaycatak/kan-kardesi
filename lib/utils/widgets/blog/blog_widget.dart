import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:kan_kardesi/models/blog/blog_model.dart';
import 'package:kan_kardesi/services/router/route_constants.dart';
import 'package:kan_kardesi/services/router/router_service.dart';
import 'package:kan_kardesi/style/theme/custom_theme.dart';
import 'package:kan_kardesi/utils/constants/constants.dart';
import 'package:kan_kardesi/utils/constants/image/image_constants.dart';

class BlogWidget extends StatelessWidget {
  final BlogModel blog;
  const BlogWidget({
    super.key,
    required this.blog,
  });

  @override
  Widget build(BuildContext context) {
    return PlatformTextButton(
      onPressed: () {
        RouterService.goNamed(
          context: context,
          route: RouteConstants().blog_detail,
          extra: blog,
        );
      },
      padding: EdgeInsets.zero,
      child: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                Constants.IMAGE_URL + blog.image!,
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
                    blog.title!,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                  ),
                  Text(
                    blog.shortDescription!,
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
