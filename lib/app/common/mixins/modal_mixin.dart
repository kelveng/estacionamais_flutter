import 'package:flutter/material.dart';

mixin ModalMixin {
  modalSheet(BuildContext context, Widget child) {
    return showModalBottomSheet(
        isDismissible: false,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  child,
                ],
              ),
            ),
          );
        });
  }
}
