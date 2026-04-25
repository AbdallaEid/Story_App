import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:story_app/Views/home_view.dart';
import 'package:story_app/constants.dart';
import 'package:story_app/models/story_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/simple_bloc_observer.dart';
import 'cubits/story_cubit/story_cubit.dart';

void main() async {
  await Hive.initFlutter(); //Finds the right path: On mobile devices
  Bloc.observer = SimpleBlocObserver();
  Hive.registerAdapter(StoryModelAdapter());
  await Hive.openBox<StoryModel>(Constants.kStoryBoxKey);
  // Register adapter so Hive can convert StoryModel objects to and from stored data
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => StoryCubit())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: const HomeView(),
      ),
    );
  }
}
