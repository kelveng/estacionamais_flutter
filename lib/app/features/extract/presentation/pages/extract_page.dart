import 'package:estaciona_mais/app/common/icons/icons_app.dart';
import 'package:estaciona_mais/app/common/themes/app_colors.dart';
import 'package:estaciona_mais/app/common/themes/app_text_styles.dart';
import 'package:estaciona_mais/app/features/extract/data/models/resume_space_model.dart';
import 'package:estaciona_mais/app/features/extract/domain/entities/resume_space.dart';
import 'package:estaciona_mais/app/features/extract/presentation/bloc/extract_cubit.dart';
import 'package:estaciona_mais/app/features/extract/presentation/bloc/extract_state.dart';
import 'package:estaciona_mais/app/features/extract/presentation/widgets/amount_widget.dart';
import 'package:estaciona_mais/app/features/extract/presentation/widgets/filter_date_widget.dart';
import 'package:estaciona_mais/app/features/extract/presentation/widgets/space_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ExtractPage extends StatefulWidget {
  const ExtractPage({Key key}) : super(key: key);

  @override
  _ExtractPageState createState() => _ExtractPageState();
}

class _ExtractPageState extends State<ExtractPage> {
  ExtractCubit cubit;

  @override
  void initState() {
    cubit = Modular.get<ExtractCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit..loadExtract(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: BackButton(
              color: AppColors.white,
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("ESTACIONA+", style: TextStyles.appNameBoldWhite)
              ],
            ),
          ),
          body: BlocBuilder<ExtractCubit, ExtractState>(
            builder: (context, state) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    IconsApp.background,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    color: Color.fromRGBO(0, 0, 0, 0.9),
                  ),
                  _build(state)
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _build(ExtractState state) {
    return Container(
      child: Column(
        children: [
          Container(
            height: AppBar().preferredSize.height,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Extrato - Historico de Vagas",
                  style: TextStyles.textFilterDate,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: FilterDateWidget(
              dateTime: state.dateTime,
              onPressBack: () => cubit.backDate(),
              onPressNext: () => cubit.nextDate(),
            ),
          ),
          state is LoadState ? AmountWidget(amount: state.amount) : Container(),
          Expanded(
              child: state is LoadState
                  ? _buildList(state.resumes)
                  : _buildLoading(state))
        ],
      ),
    );
  }

  Widget _buildLoading(state) {
    if (state is RefreshState) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is ErrorState) {
      return Center(
        child: Text(
          state.error,
          style: TextStyles.textFilterDate,
        ),
      );
    } else {
      return Container();
    }
  }

  _buildList(List<ResumeSpace> resumes) {
    return ListView.builder(
      itemCount: resumes.length,
      reverse: false,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: SpaceWidget(
            resumeSpace: resumes[index],
          ),
        );
      },
    );
  }
}
