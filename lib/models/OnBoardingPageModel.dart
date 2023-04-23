import 'package:flutter/material.dart';
import 'package:onboarding/onboarding.dart';

class OnBoardingPageModel extends StatefulWidget {
  final String pageTitle;
  final String pageInfo;

  const OnBoardingPageModel({
    Key? key,
    required this.pageTitle,
    required this.pageInfo,
  }) : super(key: key);

  @override
  State<OnBoardingPageModel> createState() => _OnBoardingPageModelState();
}

class _OnBoardingPageModelState extends State<OnBoardingPageModel> {
  @override
  Widget build(BuildContext context) {
    return PageModel(
      widget: Center(
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 45.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    widget.pageTitle,
                    style: pageTitleStyle,
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 45.0, vertical: 10.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    widget.pageInfo,
                    style: pageInfoStyle,
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ).widget;
  }
}
