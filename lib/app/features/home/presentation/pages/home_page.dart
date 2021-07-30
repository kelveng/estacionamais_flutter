import 'package:estaciona_mais/app/common/components/dashboard_container_component.dart';
import 'package:estaciona_mais/app/common/navagate/routes.dart';
import 'package:estaciona_mais/app/common/themes/app_colors.dart';
import 'package:estaciona_mais/app/features/home/data/models/price_model.dart';
import 'package:estaciona_mais/app/features/home/domain/entities/entities.dart';
import 'package:estaciona_mais/app/features/home/domain/usecases/use_case.dart';
import 'package:estaciona_mais/app/features/home/presentation/bloc/home_cubit.dart';
import 'package:estaciona_mais/app/features/home/presentation/bloc/home_state.dart';
import 'package:estaciona_mais/app/features/home/presentation/widgets/balance_resume_widget.dart';
import 'package:estaciona_mais/app/features/home/presentation/widgets/custom_clip_path.dart';
import 'package:estaciona_mais/app/features/home/presentation/widgets/info_app_widget.dart';
import 'package:estaciona_mais/app/features/home/presentation/widgets/price_widget.dart';
import 'package:estaciona_mais/app/features/home/presentation/widgets/space_indicatior_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final double appBarHeight = 200;
  final double spaceIndicatorHeight = 120;
  final double balanceResumeHeight = 130;
  final double pricesHeight = 130;
  HomeCubit cubit;

  @override
  void initState() {
    cubit = Modular.get<HomeCubit>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit..loadDashboard(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(appBar: _buildAppBar(), body: _build(state));
        },
      ),
    );
  }

  Widget _build(HomeState state) {
    switch (state.runtimeType) {
      case LoadingState:
        return _buildShimmerLoading();
      case SucessState:
        return _buildDashboard((state as SucessState).dashboard);
      default:
        return Container(color: AppColors.secondary);
    }
  }

  _buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(appBarHeight),
      child: Container(
        color: AppColors.secondary,
        child: ClipPath(
          clipper: AppBarCustomClipper(),
          child: Container(
            height: appBarHeight,
            color: AppColors.primary,
            child: Center(child: InfoAppBarWidget()),
          ),
        ),
      ),
    );
  }

  Widget _buildDashboard(Dashboard dashboard) {
    return Container(
      color: AppColors.secondary,
      child: Column(
        children: [
          GestureDetector(
            onTap: () async {
              await Modular.to.pushNamed(Routes.spaceManagament);
              cubit.loadDashboard();
            },
            child: SpaceIndicatorWidget(
                max: dashboard.capacitySpace.totalParkingLotsCount,
                current: dashboard.capacitySpace.occupiedParkingLots,
                height: spaceIndicatorHeight),
          ),
          BalanceResumeWidget(
            height: balanceResumeHeight,
            amount: dashboard.balanceResume.amount,
            date: dashboard.balanceResume.date,
          ),
          PriceWidget(height: pricesHeight, prices: dashboard.priceList.prices)
        ],
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return Container(
      color: AppColors.secondary,
      child: Shimmer.fromColors(
        baseColor: AppColors.shadow,
        highlightColor: AppColors.grey,
        child: Column(
          children: [
            DashboardContainerComponent(height: spaceIndicatorHeight),
            DashboardContainerComponent(
              height: balanceResumeHeight,
            ),
            DashboardContainerComponent(height: pricesHeight)
          ],
        ),
      ),
    );
  }
}
