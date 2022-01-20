import 'package:flutter/material.dart';
import 'package:sqfliteproject/constant.dart';

Widget listItem(Map item) => Padding(
  padding: const EdgeInsets.all(8.0),
  child: Row(
    children: [
      CircleAvatar(
        backgroundColor: Constants.projectColor,
        radius: 40.0,
        child: Center(
          child: Text(
              '${item['age']}', style: TextStyle(
            fontSize: 12
          ),
          ),
        ),
      ),
      const SizedBox(width: 20.0),
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${item["name"]}',
            style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold
            ),
          ),
        ],
      )
    ],
  ),
);