import 'package:estaciona_mais/app/common/themes/app_colors.dart';
import 'package:estaciona_mais/app/features/home/presentation/widgets/custom_clip_path.dart';
import 'package:estaciona_mais/app/features/home/presentation/widgets/info_app_widget.dart';
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
        child: ClipPath(
          clipper: AppBarCustomClipper(),
          child: Container(
            height: 200,
            color: AppColors.primary,
            child: Center(child: InfoAppBarWidget()),
          ),
        ),
      ),
      body: Container(),
    );
  }
}
