import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:sambanew/controller/homeController.dart';

class Privacypolicy extends StatefulWidget {
  const Privacypolicy({super.key});

  @override
  State<Privacypolicy> createState() => _PrivacypolicyState();
}

class _PrivacypolicyState extends State<Privacypolicy> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<HomepageController>().getPrivacyPolicy();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 1,
          title: Text(
            "Privacy Policy",
            style: Theme.of(context).textTheme.headlineMedium,
          )),
      body: GetBuilder<HomepageController>(builder: (controller) {
        return controller.privacyPolicy.isNotEmpty
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: HtmlWidget(
                        """${controller.privacyPolicy.first['privacyPolicy']}""",
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )
            : Center(
                child: Container(
                  decoration: BoxDecoration(
                     color: Colors.white,
              borderRadius: BorderRadiusDirectional.circular(50)
                  ),
                  width: 80,
                  height: 80,
                  child:ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          'assets/images/preloader.gif',
                        ),
                      ),
                ),
              );
      }),
    );
  }
}
