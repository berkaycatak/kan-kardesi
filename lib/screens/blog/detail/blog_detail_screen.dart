import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:html2md/html2md.dart' as html2md;
import 'package:kan_kardesi/models/blog/blog_model.dart';
import 'package:kan_kardesi/style/theme/custom_theme.dart';
import 'package:kan_kardesi/utils/components/app/custom_appbar_widget.dart';
import 'package:kan_kardesi/utils/constants/constants.dart';
import 'package:kan_kardesi/utils/helpers/helpers.dart';
import 'package:url_launcher/url_launcher.dart';

class BlogDetailScreen extends StatefulWidget {
  final BlogModel blog;
  const BlogDetailScreen({super.key, required this.blog});

  @override
  State<BlogDetailScreen> createState() => _BlogDetailScreenState();
}

class _BlogDetailScreenState extends State<BlogDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      backgroundColor: const Color.fromRGBO(238, 238, 243, 1),
      appBar: customAppBar(
        context,
        title: widget.blog.title! * 1,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 250,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  // bottomLeft: Radius.circular(10),
                  // bottomRight: Radius.circular(10),
                  ),
              child: Image.network(
                Constants.IMAGE_URL + widget.blog.image!,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: Padding(
              padding: CustomTheme.screenPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.blog.user!.name!,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        Helpers.dateFormatter(widget.blog.createdAt!)!,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  const Divider(),
                  const SizedBox(height: 6),
                  MarkdownBody(
                    data: html2md.convert(
                      widget.blog.description!,
                    ),
                    styleSheet: MarkdownStyleSheet(
                      h2: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    onTapLink: (text, url, title) async {
                      if (url != null) {
                        Uri myUri = Uri.parse(url);
                        if (!await launchUrl(myUri)) {
                          throw 'Could not launch $url';
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
