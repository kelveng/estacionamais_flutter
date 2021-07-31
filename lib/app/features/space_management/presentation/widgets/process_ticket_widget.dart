import 'package:estaciona_mais/app/common/themes/app_colors.dart';
import 'package:estaciona_mais/app/common/themes/app_text_styles.dart';
import 'package:estaciona_mais/app/features/space_management/presentation/widgets/custom_button_widget.dart';
import 'package:estaciona_mais/app/features/space_management/presentation/widgets/custom_textfield_widget.dart';
import 'package:flutter/material.dart';

class ProcessTicketWidget extends StatelessWidget {
  TextEditingController placeController = TextEditingController(text: "");
  TextEditingController hourController = TextEditingController(text: "");
  final Function(String place) onPressConfirm;
  final Function onPressCancel;
  final String hourNow;
  final String spaceDescription;
  final String message;
  final String place;
  final bool isLoading;
  ProcessTicketWidget(
      {Key key,
      this.hourNow = "20:00",
      this.spaceDescription,
      this.onPressConfirm,
      this.onPressCancel,
      this.message = "",
      this.place = "",
      this.isLoading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    hourController.text = hourNow;
    placeController.text = place;
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
              "Vaga $spaceDescription",
              style: TextStyles.titleBoxProcessGreen,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              height: 1,
              color: AppColors.greyLight,
            ),
          ),
          Container(
            height: 100,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomTextFieldWidget(
                  controller: placeController,
                  title: "Placa Veículo",
                  hintText: "Digite a placa",
                ),
                CustomTextFieldWidget(
                  enable: false,
                  controller: hourController,
                  title: "Hora Entrada",
                  hintText: "99:99",
                ),
              ],
            ),
          ),
          _buildMessage(),
          isLoading
              ? Center(child: CircularProgressIndicator())
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomButtonWidget(
                      backGroundColor: AppColors.green,
                      title: "Voltar",
                      onPress: onPressCancel,
                    ),
                    CustomButtonWidget(
                      backGroundColor: AppColors.green,
                      title: "Entrada",
                      onPress: () => onPressConfirm(placeController.text),
                    )
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
