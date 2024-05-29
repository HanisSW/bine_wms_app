import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wms_project/screen/login_page.dart';
import 'package:wms_project/screen/main_page.dart';
import 'package:wms_project/screen/splash_page.dart';
import 'package:wms_project/testscreen/test_page2.dart';

// void main() async{
//
//   WidgetsFlutterBinding.ensureInitialized();
//   await EasyLocalization.ensureInitialized();
//   runApp(
//     //다국어 설정
//     EasyLocalization(
//       supportedLocales: const [Locale('ko', 'KR'), Locale('en', 'US')],
//       path: 'assets/translations',
//       // supportedLocales에서 설정한 언어에 해당되는게 없으면 한글로 나오도록 설정
//       fallbackLocale: const Locale('ko', 'KR'),
//       child: WmsStart(),
//     ),
//   );
// }
//
//
// class WmsStart extends StatelessWidget {
//   const WmsStart({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ProviderScope(
//       child: MaterialApp(
//         theme: ThemeData(
//          fontFamily: 'NotoSans',
//         ),
//         localizationsDelegates: context.localizationDelegates,
//         supportedLocales: context.supportedLocales,
//         locale: context.locale,
//         home: SplashPage(),
//       ),
//     );
//   }
// }


void main() async{
  runApp(
    ProviderScope(
      child: MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: SplashPage(),
      ),
    ),
  );
}

