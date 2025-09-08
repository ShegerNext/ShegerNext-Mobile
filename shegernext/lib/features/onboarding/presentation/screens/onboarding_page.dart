import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shegernext/core/config/route_names.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToNextPage() {
    if (_currentPageIndex < 3) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      if (mounted) context.go(RouteNames.home);
    }
  }

  void _goToPreviousPage() {
    if (_currentPageIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            _Header(
              onSkip: () => context.go(RouteNames.home),
              controller: _pageController,
              pageCount: 4,
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (int index) =>
                    setState(() => _currentPageIndex = index),
                children: const <Widget>[
                  _OnboardSlide(
                    title: 'Smart Municipality',
                    subtitle: 'Complaint Resolution System',
                    description:
                        'Report and track municipal issues in your community. Connect directly with local officers for faster resolution.',
                    iconBackgroundColor: Color(0xFF661AFF),
                    iconColor: Colors.white,
                    indicatorActiveColor: Color(0xFF661AFF),
                  ),
                  _OnboardSlide(
                    title: 'Submit Complaints',
                    subtitle: 'Report issues with photos and location',
                    description: '',
                    iconBackgroundColor: Color(0xFF661AFF),
                    iconColor: Colors.white,
                    indicatorActiveColor: Color(0xFF4A3AFF),
                  ),
                  _OnboardSlide(
                    title: 'Track Progress',
                    subtitle: 'Get real-time updates on your complaints',
                    description: '',
                    iconBackgroundColor: Color(0xFF1BC464),
                    iconColor: Colors.white,
                    indicatorActiveColor: Color(0xFF3E6BFF),
                    icon: Icons.arrow_upward_sharp,
                  ),
                  _OnboardSlide(
                    title: 'Community Voice',
                    subtitle: 'Upvote important issues to increase priority',
                    description: '',
                    iconBackgroundColor: Color.fromARGB(255, 94, 30, 52),
                    iconColor: Colors.white,
                    indicatorActiveColor: Color(0xFF3E6BFF),
                    icon: Icons.check_circle,
                  ),
                ],
              ),
            ),
            _Footer(
              currentPageIndex: _currentPageIndex,
              onBack: _goToPreviousPage,
              onNext: _goToNextPage,
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xFFF3F5FF),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.onSkip,
    required this.controller,
    required this.pageCount,
  });

  final VoidCallback onSkip;
  final PageController controller;
  final int pageCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const SizedBox(width: 24, height: 24),
          _SmoothPageDots(controller: controller, count: pageCount),
          TextButton(onPressed: onSkip, child: const Text('Skip')),
        ],
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer({
    required this.currentPageIndex,
    required this.onBack,
    required this.onNext,
  });

  final int currentPageIndex;
  final VoidCallback onBack;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final bool isLast = currentPageIndex == 3;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          OutlinedButton.icon(
            onPressed: currentPageIndex > 0 ? onBack : null,
            icon: const Icon(Icons.arrow_back_ios_new, size: 16),
            label: const Text('Back'),
          ),
          ElevatedButton(
            onPressed: onNext,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF661AFF),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(isLast ? 'Get Started' : 'Next'),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_forward, size: 18),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardSlide extends StatelessWidget {
  const _OnboardSlide({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.iconBackgroundColor,
    required this.iconColor,
    required this.indicatorActiveColor,
    this.icon = Icons.chat_bubble_outline
  });

  final String title;
  final String subtitle;
  final String description;
  final Color iconBackgroundColor;
  final Color iconColor;
  final Color indicatorActiveColor;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // <-- Add this line
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 96,
              width: 96,
              decoration: BoxDecoration(
                color: iconBackgroundColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 42,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: theme.textTheme.titleMedium?.copyWith(
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 12),
            if (description.isNotEmpty)
              Text(
                description,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.black54,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _SmoothPageDots extends StatefulWidget {
  const _SmoothPageDots({required this.controller, required this.count});

  final PageController controller;
  final int count;

  @override
  State<_SmoothPageDots> createState() => _SmoothPageDotsState();
}

class _SmoothPageDotsState extends State<_SmoothPageDots> {
  double _page = 0.0;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_listener);
  }

  void _listener() {
    setState(() {
      _page =
          widget.controller.page ?? widget.controller.initialPage.toDouble();
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double dotSize = 7;
    const double spacing = 8;
    final double indicatorWidth =
        widget.count * dotSize + (widget.count - 1) * spacing;

    return SizedBox(
      width: indicatorWidth,
      height: 8,
      child: Stack(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List<Widget>.generate(widget.count, (_) {
              return Container(
                width: dotSize,
                height: dotSize,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }),
          ),
          Positioned(
            left: _page * (dotSize + spacing),
            child: Container(
              width: dotSize,
              height: dotSize,
              decoration: BoxDecoration(
                color: const Color(0xFF661AFF),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
