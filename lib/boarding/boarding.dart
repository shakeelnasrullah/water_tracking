import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:water_tracker/boarding/boarding_item.dart';
import 'package:water_tracker/login.dart';

class BoardingScreen extends StatefulWidget {
  const BoardingScreen({super.key});

  @override
  State<BoardingScreen> createState() => _BoardingScreenState();
}

final List<Map<String, String>> items = [
  {
    'image': 'assets/images/boarding-1.png',
    'title': 'Track your daily water\nintake with Us.',
    'description': 'Achieve your hydration goals with a simple\ntap!'
  },
  {
    'image': 'assets/images/boarding-2.png',
    'title': 'Smart Reminders\nTailored to You',
    'description':
    'Quick and easy to set your hydration goal &\nthen track your daily water intake progress.'
  },
  {
    'image': 'assets/images/boarding-3.png',
    'title': 'Easy to Use – Drink, Tap,\nRepeat',
    'description':
    'Staying hydrated every day\nis easy with Drops Water Tracker.',
  },
];

class _BoardingScreenState extends State<BoardingScreen> {
  final PageController _controller =
  PageController(viewportFraction: 1, keepPage: true);

  int _currentPage = 0;
  Color blueColor = const Color(0xFF5DCCFC);

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _currentPage = _controller.page!.round();
      });
    });
  }

  void _goToPreviousPage() {
    if (_currentPage > 0) {
      _controller.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToNextPage() {
    if (_currentPage < items.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToDashBoard() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 8,
            child: PageView.builder(
              controller: _controller,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return BoardingItem(
                  item: items[index],
                );
              },
            ),
          ),
          SmoothPageIndicator(
            controller: _controller,
            count: items.length,
            effect: const ExpandingDotsEffect(
              activeDotColor: Colors.blue,
              dotColor: Colors.grey,
              dotHeight: 8.0,
              dotWidth: 8.0,
              spacing: 4.0,
            ),
          ),
          const SizedBox(height: 40,),
          Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
              onPressed: _currentPage < items.length - 1
                ? _goToNextPage
                : _goToDashBoard,
                style: ElevatedButton.styleFrom(
                  shadowColor: Colors.blue,
                  //foregroundColor: blueColor,
                  backgroundColor: blueColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  )),
                  child: Text(
                    _currentPage < items.length - 1 ? 'Next' : 'Get Started',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4.0,
                        color: Colors.white,
                        fontFamily: "Inter",
                        fontSize: 16),
                  ),
                ),
            ),
          ),
        ],
      ),
    );
  }
}
