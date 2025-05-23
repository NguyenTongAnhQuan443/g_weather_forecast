import 'package:flutter/material.dart';

// Widget cho text chạy ngang nếu quá dài (sử dụng cho trạng thái thời tiết dài)
class MarqueeText extends StatelessWidget {
  final String text;
  final ScrollController? scrollController;

  const MarqueeText({Key? key, required this.text, this.scrollController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 12),
          maxLines: 1,
        ),
      ),
    );
  }
}
