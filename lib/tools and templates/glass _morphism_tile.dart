import 'dart:ui';
import 'package:flutter/material.dart';

class GlassTile extends StatefulWidget {
  final double width;
  final double height;
  final double radius;
  final Widget content;
  const GlassTile({super.key, required this.height, required this.width, required this.radius, required this.content});

  @override
  State<GlassTile> createState() => _GlassTileState();
}

class _GlassTileState extends State<GlassTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.radius), // Adjust the radius as needed
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.cyanAccent.withOpacity(0.1),
            Colors.white.withOpacity(0.1),
          ],
        ),
      ),
      // Apply a BackdropFilter for blurriness
      foregroundDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.radius), // Adjust the radius as needed
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.radius), // Adjust the radius as needed
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            color: Colors.white.withOpacity(0.1),
            child: widget.content
          )
        )
      )
    );
  }
}
