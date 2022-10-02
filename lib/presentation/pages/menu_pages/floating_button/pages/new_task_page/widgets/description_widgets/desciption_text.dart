import 'package:flutter/material.dart';

const  desciptionTextWidget =   Padding(
            padding: EdgeInsets.only(
              left: 15,
              bottom: 10,
            ),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Description',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );