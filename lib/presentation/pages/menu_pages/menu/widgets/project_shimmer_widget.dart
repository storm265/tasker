import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerProjectItem extends StatelessWidget {

  ShimmerProjectItem({Key? key}) : super(key: key);
  final hightlightColor = Colors.grey.shade300;
  final baseColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 180,
      color: baseColor,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Shimmer.fromColors(
          baseColor: baseColor,
          highlightColor: hightlightColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Shimmer.fromColors(
                baseColor: baseColor,
                highlightColor: Colors.grey.withOpacity(0.99),
                child: const Align(
                  alignment: Alignment.topLeft,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.red,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Wrap(
                  spacing: 5,
                  direction: Axis.vertical,
                  children: [
                    Container(width: 100, color: Colors.grey, height: 10),
                    Container(width: 100, color: Colors.grey, height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
