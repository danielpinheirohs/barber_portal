import 'package:flutter/material.dart';

class BRBButton extends StatelessWidget {
  final String? text;
  final double? width;
  final double? height;
  final Color? color;
  final Function()? onPressed;
  final bool isLoading;

  const BRBButton({
    super.key,
    this.text,
    this.width,
    this.height,
    this.onPressed,
    this.isLoading = false,
    this.color,
  });

  const BRBButton.large({
    super.key,
    this.text,
    this.height,
    this.onPressed,
    this.isLoading = false,
    this.color,
  }) : width = double.infinity;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height ?? 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
          backgroundColor: color ?? const Color(0xff2FB9D0),
        ),
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : Text(
                text ?? 'Botão',
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
      ),
    );
  }
}
