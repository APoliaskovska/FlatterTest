import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../widgets/small_text.dart';

class ErrorContainer extends StatelessWidget {
  final String? errorText;
  VoidCallback onTap;

  ErrorContainer(this.errorText, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SmallText(
              text: "Error loading data...\nTry again later",
              color: Colors.red,
              textAlign: TextAlign.center),
          IconButton(icon: const Icon(Icons.update),
            color: AppColors.primaryColor,
            onPressed: () {
              onTap();
            },
          )
        ],
      ),
    );
  }
}