import 'package:estaciona_mais/app/common/themes/app_text_styles.dart';
import 'package:estaciona_mais/app/common/utils/money_format.dart';
import 'package:estaciona_mais/app/common/widgets/divider_vertical_widget.dart';
import 'package:estaciona_mais/app/features/extract/domain/entities/resume_space.dart';
import 'package:flutter/material.dart';

class SpaceWidget extends StatelessWidget {
  final ResumeSpace resumeSpace;
  const SpaceWidget({Key key, this.resumeSpace}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Vaga ${resumeSpace.description}",
                  style: TextStyles.textFilterDate,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  MoneyFormatter.format(resumeSpace.total),
                  style: TextStyles.textFilterDate,
                ),
              ),
            ],
          ),
          DividerVerticalWidget(),
        ],
      ),
    );
  }
}
