import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm/res/colors/app_colors.dart';

class InternetExceptionWidget extends StatefulWidget {
  final VoidCallback onPress;
  const InternetExceptionWidget({super.key,required this.onPress});

  @override
  State<InternetExceptionWidget> createState() =>
      _InternetExceptionWidgetState();
}

class _InternetExceptionWidgetState extends State<InternetExceptionWidget> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: height * .15,
            ),
            const Icon(
              Icons.cloud_off,
              color: AppColor.redColor,
              size: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Center(
                  child: Text(
                'internet_exception'.tr,
                textAlign: TextAlign.center,
              )),
            ),
            SizedBox(
              height: height * .15,
            ),
            InkWell(
              onTap: widget.onPress,
              child: Container(
                height: 44,
                width: 160,
                decoration: BoxDecoration(
                  color: AppColor.primaryColor,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                  child: Text(
                    'Retry',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
