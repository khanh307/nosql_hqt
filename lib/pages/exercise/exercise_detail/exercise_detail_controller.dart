import 'package:chewie/chewie.dart';
import 'package:fitness_tracker/pages/bottom_nav/bottom_nav_controller.dart';
import 'package:fitness_tracker/pages/exercise/exercise_controller.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../../../models/exercise_model.dart';

class ExerciseDetailController extends GetxController {
  final ExerciseModel model = Get.arguments;
  late VideoPlayerController videoController;
  late VideoPlayerController videoController2;
  Rx<ChewieController?> chewieController = Rx(null);
  Rx<ChewieController?> chewieController2 = Rx(null);
  RxBool isSelected = BottomNavController.instants.isSelected.obs;

  @override
  void onReady() async {
    super.onReady();
    videoController = VideoPlayerController.networkUrl(
      Uri.parse(model.videos!.first),
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );
    await videoController.initialize();
    chewieController.value = ChewieController(
        videoPlayerController: videoController,
        autoInitialize: true,
        autoPlay: true,
        isLive: true,
        looping: true,
        showControls: false);

    videoController2 = VideoPlayerController.networkUrl(
      Uri.parse(model.videos!.last),
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );
    await videoController2.initialize();
    chewieController2.value = ChewieController(
        videoPlayerController: videoController2,
        autoPlay: true,
        isLive: true,
        looping: true,
        showControls: false);
  }

  void pickExercise() {

  }

  void removeExercise() {

  }
}
