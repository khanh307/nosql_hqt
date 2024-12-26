import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fitness_tracker/utils/const/app_colors.dart';
import 'package:fitness_tracker/widgets/text_widget.dart';

import '../widgets/loading_widget.dart';

class DialogUtil {
  static Future showSnackBar(String message) async {
    if (Get.isSnackbarOpen) {
      await Get.closeCurrentSnackbar();
    }
    Get.showSnackbar(GetSnackBar(
      message: message,
      backgroundColor: AppColors.primaryColor,
      messageText: TextWidget(
        text: message,
        color: Colors.white,
        fontWeight: FontWeight.w500,
        size: 16,
      ),
      borderRadius: 10.0,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      duration: const Duration(milliseconds: 1000),
      animationDuration: const Duration(milliseconds: 500),
    ));
  }

  static Future showLoading(
      {bool isClosed = true, VoidCallback? actionClose}) async {
    if (Get.isSnackbarOpen) {
      await Get.closeCurrentSnackbar();
    }
    Get.defaultDialog(
        backgroundColor: Colors.transparent,
        title: '',
        titlePadding: EdgeInsets.zero,
        titleStyle: const TextStyle(fontSize: 0),
        contentPadding: EdgeInsets.zero,
        barrierDismissible: false,
        content: WillPopScope(
          onWillPop: () async {
            if (isClosed) {
              if (actionClose != null) {
                actionClose();
              }
              Get.back();
              Get.back();
            }
            return false;
          },
          child: Card(
            elevation: 10,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(child: LoadingWidget()),
            ),
          ),
        ));
  }

  static void hideLoading() async {
    Get.back();
  }

  static Future showDialog(
      {String title = '',
      required Widget content,
      List<ActionDialog>? actions,
      bool barrierDismissible = true}) async {
    await Get.defaultDialog(
        barrierDismissible: barrierDismissible,
        onWillPop: () async {
          return barrierDismissible;
        },
        backgroundColor: Colors.white,
        titlePadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        radius: 10,
        title: title,
        content: SizedBox(
          width: Get.width > 700 ? 500: Get.width,
          child: Column(
            children: [
              content,
              const SizedBox(
                height: 20,
              ),
              (actions != null)
                  ? Container(
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        children: List.generate(
                            actions.length,
                            (index) => Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            actions[index].onPressed();
                                          },
                                          child: TextWidget(
                                            text: actions[index].text,
                                            color: Colors.white,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      (index < actions.length - 1)
                                          ? Container(
                                              height: 40,
                                              color: Colors.white,
                                              width: 1,
                                            )
                                          : Container()
                                    ],
                                  ),
                                )),
                      ),
                    )
                  : Container()
            ],
          ),
        ));
  }

  static showDialogPermission(
      {required String permission,
      required VoidCallback action,
      bool isRequired = false}) async {
    showDialog(
        title: 'Thông báo',
        barrierDismissible: !isRequired,
        content: TextWidget(
            textAlign: TextAlign.center,
            text: 'Vui lòng cấp quyền $permission để chức năng hoạt động tốt'),
        actions: [
          ActionDialog(
            text: 'Cấp quyền',
            onPressed: () {
              action();
            },
          )
        ]);
  }

  static showDialogGPSSetting({required VoidCallback action}) {
    showDialog(
        title: 'Thông báo',
        barrierDismissible: false,
        content: const TextWidget(
            textAlign: TextAlign.center,
            text:
                'Vui lòng cấp quyền bật Định vị (GPS) để chức năng hoạt động tốt'),
        actions: [
          ActionDialog(
            text: 'Cấp quyền',
            onPressed: () {
              action();
            },
          )
        ]);
  }

  static void showDialogUpdate(
      {required String text,
      required VoidCallback action,
      required Widget widget}) {
    Get.dialog(
      WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: AlertDialog(
          titlePadding: EdgeInsets.zero,
          backgroundColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          title: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(6.0),
                  topRight: Radius.circular(6.0)),
              child: Image.asset('assets/dialog/update.png')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 5,
              ),
              TextWidget(
                text: text,
                textAlign: TextAlign.center,
                size: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textColor,
              ),
              const SizedBox(
                height: 10,
              ),
              widget,
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  action();
                },
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: const Color(0xFF13476f),
                      borderRadius: BorderRadius.circular(5)),
                  child: const Center(
                    child: TextWidget(
                      text: 'Cập nhật',
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
      useSafeArea: false,
      barrierDismissible: true,
    );
  }

  static void showDialogSuccess(
      {required String text, VoidCallback? actionClose}) {
    Get.dialog(
      WillPopScope(
        onWillPop: () async {
          if (actionClose != null) {
            actionClose();
          }
          return true;
        },
        child: AlertDialog(
          titlePadding: EdgeInsets.zero,
          backgroundColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          title: Stack(
            children: [
              Container(
                width: Get.width > 700 ? 400: Get.width,
                height: 200,
                decoration: const BoxDecoration(
                    color: Color(0xFF2dd284),
                    // color: AppColors.primaryColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(6.0),
                        topRight: Radius.circular(6.0))),
                child: Image.asset('assets/dialog/success.png'),
              ),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    onPressed: () {
                      Get.back();
                      if (actionClose != null) {
                        actionClose();
                      }
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                    )),
              )
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 20,
              ),
              TextWidget(
                text: text,
                textAlign: TextAlign.center,
                size: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textColor,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
      useSafeArea: false,
      barrierDismissible: true,
    );
  }

  static void showDialogError(
      {required String text, VoidCallback? actionClose}) {
    Get.dialog(
      WillPopScope(
        onWillPop: () async {
          if (actionClose != null) {
            actionClose();
          }
          return true;
        },
        child: AlertDialog(
          titlePadding: EdgeInsets.zero,
          backgroundColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          title: Stack(
            children: [
              Container(
                width: Get.width > 700 ? 400: Get.width,
                height: 200,
                decoration: const BoxDecoration(
                    color: Color(0xFFe95350),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(6.0),
                        topRight: Radius.circular(6.0))),
                child: Image.asset('assets/dialog/error.png'),
              ),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    onPressed: () {
                      Get.back();
                      if (actionClose != null) {
                        actionClose();
                      }
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                    )),
              )
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 20,
              ),
              TextWidget(
                text: text,
                textAlign: TextAlign.center,
                size: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textColor,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
      useSafeArea: false,
      barrierDismissible: true,
    );
  }

  static void showDialogWarning(
      {required String text, VoidCallback? actionClose}) {
    Get.dialog(
      WillPopScope(
        onWillPop: () async {
          if (actionClose != null) {
            actionClose();
          }
          return true;
        },
        child: AlertDialog(
          titlePadding: EdgeInsets.zero,
          backgroundColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          title: Stack(
            children: [
              Container(
                width: Get.width > 700 ? 400: Get.width,
                height: 200,
                decoration: BoxDecoration(
                    color: const Color(0xFFffc822).withOpacity(0.8),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(6.0),
                        topRight: Radius.circular(6.0))),
                child: Image.asset('assets/dialog/warning.png'),
              ),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    onPressed: () {
                      Get.back();
                      if (actionClose != null) {
                        actionClose();
                      }
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                    )),
              )
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 20,
              ),
              TextWidget(
                text: text,
                textAlign: TextAlign.center,
                size: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textColor,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
      useSafeArea: false,
      barrierDismissible: true,
    );
  }
}

class ActionDialog {
  String text;
  Function() onPressed;

  ActionDialog({required this.text, required this.onPressed});
}
