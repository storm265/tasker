import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerQuickItem extends StatelessWidget {
  ShimmerQuickItem({Key? key}) : super(key: key);
  final hightlightColor = Colors.grey.shade300;
  final baseColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 200,
      color: baseColor,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Shimmer.fromColors(
          baseColor: baseColor,
          highlightColor: hightlightColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    spacing: 5,
                    direction: Axis.vertical,
                    children: [
                      Container(width: 120, color: Colors.grey, height: 3),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Container(
                            width: 200, color: Colors.grey, height: 10),
                      ),
                      SizedBox(
                        width: 12,
                        height: 100,
                        child: ListView.separated(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  height: 10,
                                  width: 10,
                                ),
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 12,
                                      height: 12,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: 0.5,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(3),
                                          color: Colors.grey),
                                    ),
                                    Container(
                                      width: 120,
                                      height: 3,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 0.5,
                                        ),
                                        borderRadius: BorderRadius.circular(3),
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Container(
                                      width: 70,
                                      color: Colors.grey,
                                      height: 10,
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
