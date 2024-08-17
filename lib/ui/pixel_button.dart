import 'package:flutter/material.dart';

class PixelButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  const PixelButton({super.key, required this.text, required this.onPressed});

  @override
  State<PixelButton> createState() => _PixelButtonState();
}

class _PixelButtonState extends State<PixelButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onPressed();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: _isPressed ? Colors.grey[700] : Colors.grey[800],
          border: Border(
            top: BorderSide(
                color: _isPressed ? Colors.grey[900]! : Colors.grey[600]!,
                width: 4),
            left: BorderSide(
                color: _isPressed ? Colors.grey[900]! : Colors.grey[600]!,
                width: 4),
            bottom: BorderSide(
                color: _isPressed ? Colors.grey[600]! : Colors.grey[900]!,
                width: 4),
            right: BorderSide(
                color: _isPressed ? Colors.grey[600]! : Colors.grey[900]!,
                width: 4),
          ),
        ),
        child: Text(
          widget.text,
          style: const TextStyle(
            fontFamily: 'PressStart2P',
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
