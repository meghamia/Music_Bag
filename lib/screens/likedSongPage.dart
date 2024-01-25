// likedSongPage.dart
import 'package:demo/model/LocalMusicModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controllers/songPlayerController.dart';
import '../model/MySongModel.dart';

class LikedSongPage extends GetView<HomePageController> {
  // var controller= Get.find<HomePageController>();


  @override
  Widget build(BuildContext context) {
    print("Liked Songs: ${controller.likedSong}");

    return GetBuilder(
      init: HomePageController(),
      builder: (controller){
        return Scaffold(
          appBar: AppBar(
            title: Text('Liked Songs'),
          ),
          body: ListView.builder(
            itemCount: controller.likedSong.length,
            itemBuilder: (context, index) {
              LocalMusicModel likedSong = controller.likedSong[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: Colors.black38,
                  child: Column(
                    children: [
                      ListTile(
                        // leading: Container(child: Image.asset('assets/images/pexels-vishnu-r-nair-1105666.jpg',fit: BoxFit.fill,)),
                        title: Text(likedSong.title!,maxLines: 1,),
                        subtitle: Text(likedSong.artist!),
                        trailing: IconButton(onPressed: (){
                          controller.onDeletePress(index);
                        },
                          icon: Icon(Icons.delete),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },

    );
  }
}



