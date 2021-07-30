import 'package:estaciona_mais/app/common/icons/icons_app.dart';
import 'package:estaciona_mais/app/common/themes/app_colors.dart';
import 'package:estaciona_mais/app/common/themes/app_text_styles.dart';
import 'package:estaciona_mais/app/features/space_management/data/models/space_model.dart';
import 'package:estaciona_mais/app/features/space_management/domain/entities/entities.dart';
import 'package:estaciona_mais/app/features/space_management/presentation/bloc/space_management_cubit.dart';
import 'package:estaciona_mais/app/features/space_management/presentation/bloc/space_management_state.dart';
import 'package:estaciona_mais/app/features/space_management/presentation/widgets/process_ticket_widget.dart';
import 'package:estaciona_mais/app/features/space_management/presentation/widgets/space_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shimmer/shimmer.dart';

class SpaceManagamentPage extends StatefulWidget {
  const SpaceManagamentPage({Key key}) : super(key: key);

  @override
  _SpaceManagamentPageState createState() => _SpaceManagamentPageState();
}

class _SpaceManagamentPageState extends State<SpaceManagamentPage> {
  final List<String> configMap = ["A", "FREEI", "B", "C", "FREEE", "D"];
  SpaceManagementCubit cubit;

  @override
  void initState() {
    cubit = Modular.get<SpaceManagementCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit..loadSpaces(),
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
          body: BlocBuilder<SpaceManagementCubit, SpaceManagementState>(
            builder: (context, state) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    IconsApp.background,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    color: Color.fromRGBO(0, 0, 0, 0.7),
                  ),
                  _build(state),
                  _buildOption(state)
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildOption(state) {
    if (state is RegisterEntryState) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ProcessTicketWidget(
            isLoading: false,
            spaceDescription: state.space.description,
            onPressConfirm: (place) => cubit.createTicket(state.space, place),
            onPressCancel: () => cubit.backToMap(),
          )
        ],
      );
    } else if (state is ErrorProcessState) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ProcessTicketWidget(
            message: state.error,
            isLoading: false,
            spaceDescription: state.space.description,
            onPressConfirm: (place) => cubit.createTicket(state.space, place),
            onPressCancel: () => cubit.backToMap(),
          )
        ],
      );
    } else {
      return Container();
    }
  }

  Widget _build(state) {
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
                  "Controle de Vagas",
                  style: TextStyles.titleIndicator,
                ),
              )
            ],
          ),
          state is LoadingState
              ? _buildShimmerLoading()
              : _buildMap(state.spaces)
        ],
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return Shimmer.fromColors(
      child: _buildMap(generationSpaceFree()),
      baseColor: AppColors.shadow,
      highlightColor: AppColors.grey,
    );
  }

  Widget _buildMap(List<Space> spaces) {
    List<Widget> sessions = [];

    for (var i = 0; i < configMap.length; i++) {
      if (configMap[i].contains("FREE")) {
        sessions.add(Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                configMap[i] == "FREEI" ? "Entrada" : "Saída",
                style: TextStyles.titleIndicator,
              ),
            ),
            Container(
                width: 60,
                child: Icon(
                  configMap[i] == "FREEI"
                      ? Icons.arrow_circle_down_sharp
                      : Icons.arrow_circle_up,
                  size: 50,
                  color: Colors.white,
                )),
            Container()
          ],
        ));
      } else {
        List<Space> spacesSessions =
            spaces.where((s) => s.description.contains(configMap[i])).toList();
        sessions.add(_buildSession(spacesSessions));
      }
    }

    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: sessions,
        ),
      ],
    );
  }

  Widget _buildSession(List<Space> spaces) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (var i = 0; i < spaces.length; i++)
          GestureDetector(
            onTap: () {
              cubit.selectSpace(spaces[i]);
            },
            child: SpaceContainer(
                isFree: spaces[i].isBusy,
                title: spaces[i].description,
                size: 50),
          )
      ],
    );
  }

  List<Space> generationSpaceFree() {
    List<Space> spaces = [];

    for (var i = 0; i < 10; i++) {
      spaces.add(SpaceModel(i + 1, "A${i + 1}", false, 0));
    }

    for (var i = 0; i < 8; i++) {
      spaces.add(SpaceModel(i + 1, "B${i + 1}", false, 0));
    }

    for (var i = 0; i < 8; i++) {
      spaces.add(SpaceModel(i + 1, "C${i + 1}", false, 0));
    }

    for (var i = 0; i < 10; i++) {
      spaces.add(SpaceModel(i + 1, "D${i + 1}", false, 0));
    }
    return spaces;
  }
}
