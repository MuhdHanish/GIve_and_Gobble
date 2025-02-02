import 'package:flutter/material.dart';
import 'package:give_gobble/controller/consts/const.dart';

class RestuarantCardWidget extends StatelessWidget {
  RestuarantCardWidget({super.key, required this.text, required this.image});
  final String text;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade600,
                offset: const Offset(4, 4),
                blurRadius: 15,
                spreadRadius: 1),
            const BoxShadow(
                color: Colors.white,
                offset: Offset(-4, -4),
                blurRadius: 15,
                spreadRadius: 1)
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            image,
            width: 45,
            height: 45,
          ),
          Text(
            text,
            style:
                textStyleFuc(weight: FontWeight.w300, color: kBlack, size: 10),
          )
        ],
      ),
    );
  }
}
