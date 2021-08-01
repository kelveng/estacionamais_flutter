import 'package:estaciona_mais/app/common/themes/app_colors.dart';
import 'package:estaciona_mais/app/common/themes/app_text_styles.dart';
import 'package:estaciona_mais/app/features/space_management/presentation/widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';

class ErrorModalWidget extends StatelessWidget {
  final Function onPressBack;
  final Function onPressTryAgain;
  final bool hasTryAgain;
  final String message;
  ErrorModalWidget({
    Key key,
    this.onPressBack,
    this.onPressTryAgain,
    this.hasTryAgain = false,
    this.message = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 2.0,
            spreadRadius: 0.0,
            offset: Offset(8.0, 8.0), // shadow direction: bottom right
          )
        ],
      ),
      width: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              "Erro",
              style: TextStyles.titleBoxProcessRed,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              height: 1,
              color: AppColors.greyLight,
            ),
          ),
          _buildMessage(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButtonWidget(
                backGroundColor: AppColors.red,
                title: "Voltar",
                onPress: onPressBack,
              ),
              hasTryAgain
                  ? CustomButtonWidget(
                      backGroundColor: AppColors.red,
                      title: "Tentar novamente",
                      onPress: onPressTryAgain,
                    )
                  : Container()
            ],
          )
        ],
      ),
    );
  }

  Widget _buildMessage() {
    return message.isNotEmpty
        ? Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Text(
              message,
              style: TextStyles.textErrormessage,
            ),
          )
        : Container();
  }
}
