import 'package:flutter/material.dart';
import 'package:getx_mvvm/res/colors/app_colors.dart';

class RoundButton extends StatelessWidget {
  const RoundButton({
    super.key,
    this.buttonColor = AppColor.primaryButtonColor,
    this.textColor = AppColor.primaryTextColor,
    required this.title,
    required this.onPress,
    this.width = 60,
    this.height = 50,
    this.isLoading = false,
  });

  final bool isLoading;
  final String title;
  final double height, width;
  final VoidCallback onPress;
  final Color textColor, buttonColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: isLoading?Center(child: CircularProgressIndicator()):Center(
          child: Text(title,style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: textColor
          ),),
        ),
      ),
    );
  }
}
