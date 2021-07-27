import 'package:estaciona_mais/app/common/themes/app_colors.dart';
import 'package:estaciona_mais/app/features/home/data/models/price_model.dart';
import 'package:estaciona_mais/app/features/home/domain/entities/entities.dart';
import 'package:estaciona_mais/app/features/home/presentation/widgets/balance_resume_widget.dart';
import 'package:estaciona_mais/app/features/home/presentation/widgets/custom_clip_path.dart';
import 'package:estaciona_mais/app/features/home/presentation/widgets/info_app_widget.dart';
import 'package:estaciona_mais/app/features/home/presentation/widgets/price_widget.dart';
import 'package:estaciona_mais/app/features/home/presentation/widgets/space_indicatior_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200),
        child: Container(
          color: AppColors.secondary,
          child: ClipPath(
            clipper: AppBarCustomClipper(),
            child: Container(
              height: 200,
              color: AppColors.primary,
              child: Center(child: InfoAppBarWidget()),
            ),
          ),
        ),
      ),
      body: Container(
        color: AppColors.secondary,
        child: Column(
          children: [
            SpaceIndicatorWidget(
              max: 100,
              current: 70,
            ),
            BalanceResumeWidget(
              amount: 1432.32,
              date: DateTime.now(),
            ),
            PriceWidget(prices: [
              PriceModel(0, 1, 1.50),
              PriceModel(1, 2, 2.50),
              PriceModel(3, 18, 10)
            ])
          ],
        ),
      ),
    );
  }
}
