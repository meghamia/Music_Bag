//
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// import 'package:get/get.dart';
// import 'package:on_audio_query/on_audio_query.dart';
//
// import '../model/MySongModel.dart';
//
// class CloudSongController extends GetxController {
//
//   final db = FirebaseFirestore.instance;
//
//
//   List<MySongModel> cloudSongList = [];
//
//  // List<MySongModel> searchSongList = [];
//
//
// // TextEditingController searchController=TextEditingController();
// //
// //   void SearchQuery(String query){
// //     if(query.isEmpty){
// //       searchSongList.assignAll(cloudSongList);
// //     }else {
// //       searchSongList.assignAll(cloudSongList.where((song) => song.title!.toLowerCase().contains(query.toLowerCase()),
// //       ));
// //     }
// //     update();
// //   }
//
//
//   @override
//   void onInit() {
//     getCloudSound();
//     //searchSongList.assignAll(cloudSongList);
//     // TODO: implement onInit
//     super.onInit();
//   }
//
//   void uploadSongToDB() async {
//     MySongModel newSong = MySongModel(
//       id: 1,
//       title: "  Pied-Piper.mp3",
//       artist: "Kim Taehyung",
//       album: "album",
//       albumArt: "https://i.pinimg.com/474x/7c/eb/bd/7cebbd42df42d6660246bd6c31d1c099.jpg",
//       data: "https://firebasestorage.googleapis.com/v0/b/fir-ac46d.appspot.com/o/BTS-Pied-Piper.mp3?alt=media&token=75f25179-059b-488e-9e96-96a9a5204a4d",
//     );
//
//     await db.collection("trending").add(newSong.toJson());
//     print("Song uploaded to database");
//     update();
//   }
//
//
//
//   void getCloudSound() async {
//     cloudSongList.clear();
//
//     // Fetch songs from the "songs" collection
//     await db.collection("songs").get().then((value) {
//       value.docs.forEach((element) {
//         cloudSongList.add(MySongModel.fromJson(element.data()));
//       });
//       update();
//     });
//
//     //Fetch songs from the "trending" collection
//     await db.collection("trending").get().then((value) {
//       value.docs.forEach((element) {
//         MySongModel trendingSong = MySongModel.fromJson(element.data());
//         cloudSongList.add(trendingSong); // Add trending songs to cloudSongList
//
//       });
//     });
//    update();
//
//     //cloudSongList.refresh();
//
//   }
//
// }
//
//
//





import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../model/MySongModel.dart';

class CloudSongController extends GetxController {

  final db = FirebaseFirestore.instance;


  List<MySongModel> cloudSongList = [];

 // List<MySongModel> searchSongList = [];
  // @override
  // void onReady() {
  //   super.onReady();
  // }
  //
  // void SearchQuery(String query){
  //   if(query.isEmpty){
  //     searchSongList.assignAll(cloudSongList);
  //   }else {
  //     searchSongList.assignAll(cloudSongList.where((song) => song.title!.toLowerCase().contains(query.toLowerCase()),
  //     ));
  //   }
  //   update();
  // }


  @override
  void onInit() {
    getCloudSound();
    // TODO: implement onInit
    super.onInit();
  }

  void uploadSongToDB() async {
    MySongModel newSong = MySongModel(
      id: 1,
      title: "  Pied-Piper.mp3",
      artist: "Kim Taehyung",
      album: "album",
      albumArt: "https://i.pinimg.com/474x/7c/eb/bd/7cebbd42df42d6660246bd6c31d1c099.jpg",
      data: "https://firebasestorage.googleapis.com/v0/b/fir-ac46d.appspot.com/o/BTS-Pied-Piper.mp3?alt=media&token=75f25179-059b-488e-9e96-96a9a5204a4d",
    );

    await db.collection("trending").add(newSong.toJson());
    print("Song uploaded to database");
    update();
  }



  void getCloudSound() async {
    cloudSongList.clear();

    // Fetch songs from the "songs" collection
    await db.collection("songs").get().then((value) {
      value.docs.forEach((element) {
        cloudSongList.add(MySongModel.fromJson(element.data()));
      });
      update();
    });

    //Fetch songs from the "trending" collection
    await db.collection("trending").get().then((value) {
      value.docs.forEach((element) {
        MySongModel trendingSong = MySongModel.fromJson(element.data());
        cloudSongList.add(trendingSong); // Add trending songs to cloudSongList

      });
    });
    update();

    //cloudSongList.refresh();

  }

}

