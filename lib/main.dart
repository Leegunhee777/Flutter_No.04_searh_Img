import 'package:flutter/material.dart';
import 'package:mvvmsearchimage/data/data_source/pixabay_api.dart';
import 'package:mvvmsearchimage/data/repository/photo_api_repository_impl.dart';
import 'package:mvvmsearchimage/domain/use_case/get_photos_use_case.dart';
import 'package:mvvmsearchimage/presentation/home/home_screen.dart';
import 'package:mvvmsearchimage/presentation/home/home_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      //일반 Provider를 스면 notifyListeners()에의한 변경 감지를 하지 못한다.
      //ChangeNotifierProvider를 사용해주자!
      home: ChangeNotifierProvider(
        create: ((context) => HomeViewModel(
            GetPhotosUseCase(PhotoApiRepositoryImpl(PixabayApi())))),
        child: const HomeScreen(),
      ),
    );
  }
}
