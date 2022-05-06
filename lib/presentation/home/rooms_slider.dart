import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:turing/core/utils/dimension.dart';
import 'package:turing/core/utils/styles.dart';
import 'package:turing/core/widgets/body_text.dart';
import 'package:turing/core/widgets/icon_and_text.dart';
import 'package:turing/core/widgets/title_text.dart';

class RoomsSlider extends StatefulWidget {
  const RoomsSlider({Key? key}) : super(key: key);

  @override
  State<RoomsSlider> createState() => _RoomsSliderState();
}

class _RoomsSliderState extends State<RoomsSlider> {
  final PageController pageController = PageController(viewportFraction: 0.89);
  double _currentPageValue = 0.0;
  final double _scaleFactor = 0.8;
  final double _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: Dimensions.pageView,
          // color: kMainColor,
          child: PageView.builder(
            controller: pageController,
            itemCount: 5,
            itemBuilder: (context, index) {
              return _buildPageItem(index);
            },
            physics: const BouncingScrollPhysics(),
          ),
        ),
        DotsIndicator(
          dotsCount: 5,
          position: _currentPageValue,
          decorator: DotsDecorator(
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              activeColor: itemColor,
              color: kMainColor),
        ),
      ],
    );
  }

  Widget _buildPageItem(int index) {
    Matrix4 matrix = Matrix4.identity();
    if (index == _currentPageValue.floor()) {
      var currentScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currentTrans = _height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else if (index == _currentPageValue.floor() + 1) {
      var currentScale =
          _scaleFactor + (_currentPageValue - index + 1) * (1 - _scaleFactor);
      var currentTrans = _height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1);
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else if (index == _currentPageValue.floor() - 1) {
      var currentScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currentTrans = _height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1);
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else {
      var currentScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          Container(
            height: _height,
            margin: const EdgeInsets.only(
              left: 5,
              right: 5,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: index.isEven ? evenColor : oddColor,
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/programming.jpg'),
                )),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: backgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    // spreadRadius: 1,
                    blurRadius: 3.0,
                    offset: const Offset(0, 5), // changes position of shadow
                  ),
                  const BoxShadow(
                    color: backgroundColor,
                    offset: Offset(-5, 0), // changes position of shadow
                  ),
                  const BoxShadow(
                    color: backgroundColor,
                    offset: Offset(5, 0), // changes position of shadow
                  ),
                ],
              ),
              child: Container(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 15,
                  right: 15,
                ),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleText(
                      text: 'Programming',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BodyText(
                      text:
                          'The new of Flutter version will be discussed, anyone know about can tell us',
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        IconAndText(
                          icon: Icons.people_alt_outlined,
                          iconSize: 20,
                          iconColor: iconColor,
                          text: '155',
                          textSize: 14,
                          color: bodyColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        IconAndText(
                          icon: Icons.watch_later_outlined,
                          iconSize: 20,
                          iconColor: iconColor,
                          text: '32min',
                          textSize: 14,
                          color: bodyColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
