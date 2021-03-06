import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:turing/controllers/authController.dart';
import 'package:turing/core/utils/styles.dart';
import 'package:turing/core/widgets/body_text.dart';
import 'package:turing/core/widgets/title_text.dart';
import 'package:turing/controllers/profile_controller.dart';
import 'package:turing/presentation/profile/profile_page.dart';

class ProfilePic extends StatelessWidget {

  ProfileController controller = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async{
        Get.to(() => ProfilePage(displayName: AuthController.instance.currentData.displayName, photoUrl: AuthController.instance.currentData.photoUrl),
            transition: Transition.rightToLeftWithFade,
        );
      },
      child: SizedBox(
        height: 115,
        width: 115,
        child: Stack(
          fit: StackFit.expand,
          clipBehavior: Clip.none,
          children: [
            FutureBuilder(
              future: AuthController.instance.getUserData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting){
                  return CircularProgressIndicator(
                    color: kPrimaryColor,
                    strokeWidth: 2.0,
                  );
                }
                if (snapshot.hasData){
                  return GetBuilder<ProfileController>(
                    init: ProfileController(),
                    builder: (controller) => CircleAvatar(
                        backgroundImage: NetworkImage(
                        "${AuthController.instance.currentData.photoUrl}",
                    ),
                      foregroundColor: kLightColor,
                      backgroundColor: kLightColor,
                    ),
                  );
                }
                else{
                  return CircleAvatar(
                      backgroundImage: const AssetImage(
                        "assets/images/no-user.png",
                      ),
                    foregroundColor: kLightColor,
                    backgroundColor: kLightColor,
                  );
                }
            },
            ),
            Positioned(
              right: -10,
              bottom: 4,
              child: SizedBox(
                height: 35,
                width: 35,
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                      side: const BorderSide(color: kBackgroundColor),
                    ),
                    primary: kSecondaryColor,
                    backgroundColor: kSecondaryColor,
                  ),
                  onPressed: () {
                    Get.dialog(
                      AlertDialog(
                        title: TitleText(
                          text: 'Choose option',
                          size: 20,
                          color: kPrimaryColor,
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Divider(
                              height: 1,
                            ),
                            ListTile(
                              onTap: () {
                                try {
                                  controller.cameraGetter();
                                  Get.back();
                                  controller.uploadToFirebase();
                                } catch (error) {
                                  Get.back();
                                }
                              },
                              title: BodyText(
                                text: 'Camera',
                                size: 20,
                                color: kPrimaryColor,
                              ),
                              leading: const ImageIcon(
                                AssetImage('assets/icons/camera_fill.png'),
                                color: kSecondaryColor,
                              ),
                            ),
                            const Divider(
                              height: 1,
                            ),
                            ListTile(
                              onTap: () {
                                try {
                                  controller.galleryGetter();
                                  Get.back();
                                  controller.uploadToFirebase();
                                } catch (error) {
                                  Get.back();
                                }
                              },
                              title: BodyText(
                                text: 'Gallery',
                                size: 20,
                                color: kPrimaryColor,
                              ),
                              leading: const ImageIcon(
                                AssetImage('assets/icons/image-gallery.png'),
                                color: kSecondaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                    // controller.cameraGetter();
                  },
                  child: const ImageIcon(
                      AssetImage(
                          'assets/icons/camera.png',
                      ),
                    color: kBackgroundColor,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


//GetBuilder<ProfileController>(
//               builder: (controller) => CircleAvatar(
//                 backgroundImage:  controller.image == null?
//                 const AssetImage(
//                   "assets/images/ahmedkhallaf.jpeg",
//                 )
//                     :
//                 Image.file(
//                   controller.image,
//                   fit: BoxFit.cover,
//                 ).image,
//                 backgroundColor: kPrimaryColor,
//
//               ),
//             )