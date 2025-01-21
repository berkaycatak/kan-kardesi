import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:kan_kardesi/style/theme/custom_theme.dart';
import 'package:kan_kardesi/utils/components/app/custom_appbar_widget.dart';
import 'package:kan_kardesi/utils/constants/image/image_constants.dart';

class BlogDetailScreen extends StatefulWidget {
  const BlogDetailScreen({super.key});

  @override
  State<BlogDetailScreen> createState() => _BlogDetailScreenState();
}

class _BlogDetailScreenState extends State<BlogDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      backgroundColor: const Color.fromRGBO(238, 238, 243, 1),
      appBar: customAppBar(context, title: "Kan Bağışı Yapmanın 5 Faydası!"),
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
                "https://whitworthchemists.co.uk/img/containers/assets/World-Blood-Donor-Day-Blog-June-2024.png/aafee9cb143c5ed8dd0a352e2f89bada.png",
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
                        "Berkay Çatak",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        "2 Gün Önce",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  const Divider(),
                  const SizedBox(height: 6),
                  SelectableText(
                    """1- Sağlığınızı İyileştirir
Kan bağışı, vücudun yeni kan hücreleri üretmesini tetikleyerek dolaşım sistemini yeniler ve sağlığınızı destekler.

2- Hayat Kurtarır
Verilen her ünite kan, kazazedelerden ameliyat hastalarına kadar birçok insanın hayatını kurtarabilir.

3- Kalp ve Damar Sağlığını Destekler
Düzenli kan vermek, kandaki demir seviyesini dengeleyerek kalp krizi ve damar tıkanıklığı riskini azaltabilir.""" *
                        3,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
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
