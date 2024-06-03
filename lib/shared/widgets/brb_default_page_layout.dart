import 'package:barber_portal/shared/widgets/brb_text.dart';
import 'package:flutter/material.dart';

class BRBDefaultPageLayout extends StatelessWidget {
  final String pageTitle;
  final Widget? child;
  final bool pageIsLoading;
  final Widget? rightButton;

  const BRBDefaultPageLayout({
    super.key,
    required this.pageTitle,
    this.child,
    this.pageIsLoading = false,
    this.rightButton,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: const Color(0xffF7F8FA),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BRBText.pageTitle(text: pageTitle),
                      const SizedBox(width: 36),
                      if (rightButton != null) rightButton!,
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                const Divider(
                  color: Color(0xff006B2E),
                ),
                const SizedBox(height: 42),
                if (child != null) child!,
              ],
            ),
          ),
        ),
        if (pageIsLoading)
          Container(
            color: Colors.black.withOpacity(0.5),
            child: const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          ),
      ],
    );
  }
}
