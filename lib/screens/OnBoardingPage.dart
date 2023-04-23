import 'package:flutter/material.dart';
import 'package:onboarding/onboarding.dart';

import 'package:frontend/models/OnBoardingPageModel.dart';


class OnBoardingPage extends StatefulWidget {

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  late Material materialButton;
  late int index;

  @override
  void initState() {
    super.initState();
    materialButton = _skipButton();
    index = 0;
  }

  final List<PageModel> onboardingPagesList = [
    OnBoardingPageModel(
      pageTitle: 'Hey there!',
      pageInfo: 'This is the start of your new life.',
    ),
    OnBoardingPageModel(
      pageTitle: 'TRACK YOUR PROGRESS',
      pageInfo: 'Plan, create and customize your gym experience',
    ),
    OnBoardingPageModel(
      pageTitle: 'ALL IN ONE PLACE',
      pageInfo: 'Plan, create and customize your gym experience',
    ),
    OnBoardingPageModel(
      pageTitle: 'NUTRITION',
      pageInfo: 'Find all the nutritious recipes you will ever need',
    ),
    OnBoardingPageModel(
      pageTitle: 'DONT MISS OUT',
      pageInfo:
      'Reserve machines for use, add songs to the gym playlist and even plan your class schedule!',
    ),
    OnBoardingPageModel(
      pageTitle: 'WHAT ARE YOU WAITING FOR?',
      pageInfo: '',
    ),
  ].map((page) => PageModel(widget: page)).toList();


  Material _skipButton({void Function(int)? setIndex}) {
    return Material(
      borderRadius: defaultSkipButtonBorderRadius,
      color: defaultSkipButtonColor,
      child: InkWell(
        borderRadius: defaultSkipButtonBorderRadius,
        onTap: () {
          if (setIndex != null) {
            index = 5;
            setIndex(5);
          }
        },
        child: const Padding(
          padding: defaultSkipButtonPadding,
          child: Text(
            'Skip',
            style: defaultSkipButtonTextStyle,
          ),
        ),
      ),
    );
  }

  Material get _signupButton {
    return Material(
      borderRadius: defaultProceedButtonBorderRadius,
      color: defaultProceedButtonColor,
      child: InkWell(
        borderRadius: defaultProceedButtonBorderRadius,
        onTap: () {},
        child: const Padding(
          padding: defaultProceedButtonPadding,
          child: Text(
            'Sign up',
            style: defaultProceedButtonTextStyle,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.blue[100],
    body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [ Color.fromARGB(255, 2, 77, 137),
            Color.fromARGB(255, 106, 185, 249)],
        ),
      ),
      child: Onboarding(
        pages: onboardingPagesList,
        onPageChange: (int pageIndex) {
          index = pageIndex;
        },
        startPageIndex: 0,
        footerBuilder: (context, dragDistance, pagesLength, setIndex) {
          return DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            child: Padding(
              padding: const EdgeInsets.all(45.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0, top: 8, right: 8, left: 8),
                  child: index == pagesLength - 1
                      ? _signupButton
                      : _skipButton(setIndex: setIndex),
                ),
                  Padding(
                    padding: const EdgeInsets.only(right: 115.0),
                    child: CustomIndicator(
                      netDragPercent: dragDistance,
                      pagesLength: pagesLength,
                      indicator: Indicator(
                        activeIndicator: ActiveIndicator(color: Colors.black),
                        closedIndicator: ClosedIndicator(color: Colors.black),
                        indicatorDesign: IndicatorDesign.line(
                          lineDesign: LineDesign(
                            lineType: DesignType.line_uniform,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    ),
  );
}