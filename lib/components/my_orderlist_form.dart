import 'package:flutter/material.dart';
import 'package:haedal/theme/font.dart';

class OrderListForm extends StatelessWidget {
  final String date;
  final String status;
  final Color statusColor;
  final String title;
  final String description;
  final String image;

  const OrderListForm({
    required this.date,
    required this.status,
    required this.statusColor,
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 72,
                        child: Text(
                          date,
                          style: pretendardMedium(context).copyWith(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.shadow),
                        ),
                      ),
                      SizedBox(
                        width: 60,
                        child: Text(
                          status,
                          style: pretendardMedium(context).copyWith(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.shadow
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 68,
                  height: 24,
                  decoration: ShapeDecoration(
                    color: Color(0xFFF8F9FE),//more light
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 68,
                        child: Text(
                          '주문상세',
                          textAlign: TextAlign.center,
                          style: pretendardMedium(context).copyWith(fontSize: 14,),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                    width: 84,
                    height: 84,
                  ),
                ),
                const SizedBox(width: 19),
                Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Text(
                                title,
                                style: pretendardBold(context),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Icon(Icons.keyboard_arrow_right, color: Colors.black),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        description,
                        style: pretendardRegular(context).copyWith(fontSize: 14,),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}