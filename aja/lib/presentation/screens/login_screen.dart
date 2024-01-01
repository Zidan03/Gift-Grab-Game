import 'package:aja/data/constants/globals.dart';
import 'package:aja/data/constants/screens.dart';
import 'package:aja/presentation/games/gift_grab_game.dart';
import 'package:aja/presentation/widgets/screen_background_widget.dart';
import 'package:aja/util/upper_case_text_formatter.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerWidget {
  final GiftGrabGame gameRef;

  final TextEditingController _controller = TextEditingController();

  LoginScreen({
    Key? key,
    required this.gameRef,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // NakamaProvider nakamaProvider = ref.watch(Providers.nakamaProvider);
    checkDeviceType(context);
    final theme = Theme.of(context);

    return ScreenBackgroundWidget(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: Text(
                'Login',
                style: theme.textTheme.displayLarge!.copyWith(
                  fontSize: Globals.isTablet
                      ? theme.textTheme.displayLarge!.fontSize! * 2
                      : theme.textTheme.displayLarge!.fontSize,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                controller: _controller,
                textAlign: TextAlign.center,
                maxLength: 4,
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                style: theme.textTheme.displayLarge!.copyWith(
                  fontSize: Globals.isTablet
                      ? theme.textTheme.displayLarge!.fontSize! * 2
                      : theme.textTheme.displayLarge!.fontSize,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  filled: true,
                  fillColor: Colors.black.withOpacity(0.1),
                ),
              ),
            ),
            SizedBox(
              width: Globals.isTablet ? 400 : 200,
              height: Globals.isTablet ? 100 : 50,
              child: ElevatedButton(
                onPressed: () async {
                  // String username = _controller.text;

                  // await nakamaProvider.createEmail(
                  //   email: '$username@gmail.com',
                  //   password: 'password',
                  //   username: username,
                  // );

                  gameRef.addMenu(menu: Screens.main);
                  gameRef.removeMenu(menu: Screens.login);
                },
                child: Text(
                  'Submit',
                  style: TextStyle(
                    fontSize: Globals.isTablet ? 50 : 25,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Sets the global isTablet variable based on the device type/dimensions.
  Future<void> checkDeviceType(BuildContext context) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      Globals.isTablet = iosInfo.model.contains('iPad');
    } else {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      Globals.isTablet = (androidInfo.isPhysicalDevice &&
          MediaQuery.of(context).size.width >= 600.0);
    }
  }
}
