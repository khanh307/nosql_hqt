// import 'dart:io';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:download_task/download_task.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter/foundation.dart'
//     show defaultTargetPlatform, TargetPlatform;
//
// import 'package:package_info_plus/package_info_plus.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// import '../widgets/text_widget.dart';
// import 'const/app_colors.dart';
// import 'dialog_util.dart';
//
// class CheckVersion {
//   static const String urlAPK =
//       'https://dl.dropboxusercontent.com/scl/fi/samull7w96nssqknvm0kn/fitness_app.apk?rlkey=y1cet56ra3logbuco0spsa7lg&st=28d7u5gx&dl=0';
//   static const String urlIPA =
//       'itms-services:///?action=download-manifest&url=https://appstore.vnptit.vn/CTO/iOS/VNPTCTO.plist';
//
//   static Future checkVersion(String version) async {
//     DialogUtil.showDialogUpdate(
//       text: 'Đã có phiên bản $version. Vui lòng cập nhật để sử dụng',
//       action: () async {
//         if (defaultTargetPlatform == TargetPlatform.android) {
//           await downloadFile();
//         }
//       },
//       widget: Obx(() => (progress.value > 0)
//           ? TextWidget(text: 'Đang tải xuống ${(progress.value * 100).toStringAsFixed(1)}%')
//           : Container()),
//     );
//   }
//
//   static RxDouble progress = 0.0.obs;
//
//   static Future<void> downloadFile() async {
//     var savePath =
//         '${(await getApplicationDocumentsDirectory()).path}/fitness.apk';
//     // await Permission.storage.request();
//     // var status = await Permission.manageExternalStorage.request();
//     // if (status != PermissionStatus.granted) {
//     //   status = await Permission.manageExternalStorage.request();
//     // }
//     //
//     var statusInstall = await Permission.requestInstallPackages.request();
//     if (statusInstall != PermissionStatus.granted) {
//       statusInstall = await Permission.requestInstallPackages.request();
//     }
//
//     // File file = File(savePath);
//     final task = await DownloadTask.download(Uri.parse(urlAPK),
//         file: File(savePath), safeRange: true, deleteOnError: true);
//
//     task.events.listen((event) async {
//       if (event.bytesReceived != null &&
//           event.totalBytes != null &&
//           event.bytesReceived == -1 &&
//           event.totalBytes == -1) {
//         progress.value = 0;
//       } else {
//         progress.value = (event.bytesReceived ?? 0) / (event.totalBytes ?? 1);
//       }
//       if (event.state == TaskState.success) {
//         progress.value = 1;
//         try {
//           final res = await InstallPlugin.install(savePath,
//               appId: 'com.tqk.fitness_project');
//           print('update $res');
//         } catch (e) {
//           // Get.back();
//           // DialogUtil.showDialog(
//           //     title: 'Cập nhật thất bại',
//           //     content: const Text(
//           //         'Cập nhật ứng dụng thất bại, truy cập https://onelink.vnptcantho.com.vn/qr/iuJ1dnZY9v để cập nhật thủ công.'),
//           //     actions: [
//           //       ActionDialog(
//           //         text: 'Truy cập',
//           //         onPressed: () async {},
//           //       )
//           //     ]);
//         }
//       } else if (event.state == TaskState.error) {
//         DialogUtil.showSnackBar('Lỗi tải xuống');
//       }
//     });
//   }
// }
