import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:taskati/core/constants/asset_image.dart';
import 'package:taskati/core/function/routing.dart';
import 'package:taskati/core/services/local_storage.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_style.dart';
import 'package:taskati/features/home/presentation/views/home_view.dart';
import 'package:taskati/features/upload/upload_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    bool isUpload = ProjectLocalStorage.getCashedData('isUpload') ?? false;
    Future.delayed(const Duration(seconds: 5), () {
      navigateWithReplacement(
          context, (isUpload) ? const HomeView() : const LoginView());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(ProjectImages.projectLogo),
            Text(
              'Taskati',
              style: getTitleStyle(fontSize: 30),
            ),
            const Gap(20),
            Text(
              'It\'s time to get organized',
              style: getbodyStyle(
                  color: ProjectColors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
