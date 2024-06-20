import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class SkeletonBox extends StatelessWidget {
  final double width;
  final double height;
  const SkeletonBox({required Key key, this.width = 250, this.height = 250})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: SizedBox(
              height: 35,
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SkeletonAnimation(
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      width: 160,
                      height: 25,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: height,
            width: width,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 1.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 0.5,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              children: [
                SkeletonAnimation(
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    width: 250,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      //borderRadius: BorderRadius.circular(10.0)
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SkeletonAnimation(
                      child: Container(
                        margin: const EdgeInsets.only(left: 5),
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: 15.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[300],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    SkeletonAnimation(
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: 15.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey[300],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    SkeletonAnimation(
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 15.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey[300],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: SizedBox(
              height: 35,
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SkeletonAnimation(
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      width: 160,
                      height: 25,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: height,
            width: width,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 1.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 0.5,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              children: [
                SkeletonAnimation(
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    width: 250,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      //borderRadius: BorderRadius.circular(10.0)
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SkeletonAnimation(
                      child: Container(
                        margin: const EdgeInsets.only(left: 5),
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: 15.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[300],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    SkeletonAnimation(
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: 15.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey[300],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    SkeletonAnimation(
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 15.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey[300],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: SizedBox(
              height: 35,
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SkeletonAnimation(
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      width: 160,
                      height: 25,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: height,
            width: width,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 1.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 0.5,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              children: [
                SkeletonAnimation(
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    width: 250,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      //borderRadius: BorderRadius.circular(10.0)
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SkeletonAnimation(
                      child: Container(
                        margin: const EdgeInsets.only(left: 5),
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: 15.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[300],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    SkeletonAnimation(
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: 15.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey[300],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    SkeletonAnimation(
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 15.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey[300],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
