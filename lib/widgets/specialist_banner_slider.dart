import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../models.dart';
import 'specialist_banner.dart';

class SpecialistBannerSlider extends StatefulWidget {
  final List<BannerModel> banners; // Pass banners as a prop

  SpecialistBannerSlider({required this.banners}); // Constructor for banners

  @override
  _SpecialistBannerSliderState createState() => _SpecialistBannerSliderState();
}

class _SpecialistBannerSliderState extends State<SpecialistBannerSlider> {
  final PageController _pageController = PageController();
  Timer? _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    startAutoPlay();
  }

  void startAutoPlay() {
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_pageController.hasClients) {
        if (_currentPage < widget.banners.length - 1) {
          _currentPage++;
        } else {
          _currentPage = 0;
        }
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void stopAutoPlay() {
    _timer?.cancel();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // If no banners are available, show a loading indicator
    if (widget.banners.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        GestureDetector(
          onPanDown: (details) => stopAutoPlay(),
          onPanEnd: (details) => startAutoPlay(),
          child: SizedBox(
            height: 160,
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.banners.length,
              onPageChanged: (index) => _currentPage = index,
              itemBuilder: (context, index) {
                var banner = widget.banners[index];
                return SpecialistBanner(
                  title: banner.title,
                  subtitle: banner.description,
                  imagePath: banner.image,
                  backgroundColor: Colors.green, // Customize color as needed
                );
              },
            ),
          ),
        ),
        Positioned(
          bottom: 8,
          child: SmoothPageIndicator(
            controller: _pageController,
            count: widget.banners.length,
            effect: WormEffect(
              activeDotColor: Colors.white,
              dotColor: Colors.white.withOpacity(0.5),
              dotHeight: 8,
              dotWidth: 8,
              spacing: 16,
            ),
          ),
        ),
      ],
    );
  }
}
