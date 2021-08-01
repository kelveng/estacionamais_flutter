import 'package:estaciona_mais/app/common/themes/app_colors.dart';
import 'package:estaciona_mais/app/common/themes/app_text_styles.dart';
import 'package:estaciona_mais/app/common/utils/datetime_utils.dart';
import 'package:estaciona_mais/app/common/utils/money_format.dart';
import 'package:estaciona_mais/app/features/space_management/domain/entities/entities.dart';
import 'package:estaciona_mais/app/features/space_management/presentation/widgets/custom_button_widget.dart';
import 'package:estaciona_mais/app/features/space_management/presentation/widgets/custom_textfield_widget.dart';
import 'package:flutter/material.dart';

class ManagementTicketWidget extends StatelessWidget {
  final Function onPressConfirm;
  final Function onPressCancel;
  final Function onPressBack;
  final Ticket ticket;
  final String spaceDescription;
  final String message;
  final String place;
  final bool hasError;
  final bool isLoading;

  const ManagementTicketWidget(
      {Key key,
      this.onPressConfirm,
      this.onPressCancel,
      this.onPressBack,
      this.ticket,
      this.spaceDescription,
      this.message = "",
      this.place,
      this.isLoading = false,
      this.hasError = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
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
          isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : _buildContent()
        ],
      ),
    );
  }

  Widget _buildTicket() {
    return Column(
      children: [
        Container(
          height: 70,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextFieldWidget(
                initialValue: ticket.plate,
                title: "Placa Veículo",
                hintText: "ZZZ9999",
              ),
            ],
          ),
        ),
        Container(
          height: 70,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomTextFieldWidget(
                initialValue: DateTimeUtils.getHourDate(ticket.entryTime),
                title: "Hora Entrada",
                hintText: "99:99",
              ),
              CustomTextFieldWidget(
                initialValue: DateTimeUtils.getHourDate(ticket.exitTime),
                title: "Hora Saída",
                hintText: "99:99",
              ),
            ],
          ),
        ),
        Container(
          height: 70,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomTextFieldWidget(
                initialValue: ticket.duration,
                title: "Duração",
                hintText: "99:99",
              ),
              CustomTextFieldWidget(
                initialValue: MoneyFormatter.format(ticket.amount),
                title: "Valor",
                hintText: "99.99",
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        hasError ? _buildMessage() : _buildTicket(),
        _buildSheetButton()
      ],
    );
  }

  _buildSheetButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment:
            hasError ? MainAxisAlignment.center : MainAxisAlignment.spaceEvenly,
        children: [
          CustomButtonWidget(
            backGroundColor: AppColors.red,
            title: "Voltar",
            onPress: onPressBack,
          ),
          !hasError
              ? CustomButtonWidget(
                  backGroundColor: AppColors.red,
                  title: "Estornar",
                  onPress: onPressCancel,
                )
              : Container(),
          !hasError
              ? CustomButtonWidget(
                  backGroundColor: AppColors.red,
                  title: "Saída",
                  onPress: onPressConfirm,
                )
              : Container(),
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
