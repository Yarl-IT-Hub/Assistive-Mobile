import 'package:cached_network_image/cached_network_image.dart';
import 'package:assistive_app/components/appbar.dart';
import 'package:assistive_app/constants.dart';
import 'package:assistive_app/questionLock/Lock.dart';
import 'package:assistive_app/questionLock/QuestionLock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

class Terms_Catergory extends StatefulWidget {
  Terms_Catergory({Key? key, required this.list}) : super(key: key);

  // final String title;
  final list;

  final String title = "Video Demo";

  @override
  VideoDemoState createState() => VideoDemoState();
}

class VideoDemoState extends State<Terms_Catergory> {
  // late VideoPlayerController _controller;
  // late Future<void> _initializeVideoPlayerFuture;

  // late int gradeid;

  @override
  void initState() {
    print(widget.list);
    print(widget.list['description']);
    // _controller = VideoPlayerController.network(
    //     "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4");
    //_controller = VideoPlayerController.asset("videos/sample_video.mp4");
    // _initializeVideoPlayerFuture = _controller.initialize();
    // _controller.setLooping(true);
    // _controller.setVolume(1.0);
    // gradeid = widget.gradeid;
    // print(gradeid);
    super.initState();
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  final List<Map> details = [
    {'img': 'assets/png/b4.png', "name": 'பூட்டு வீட்டை பூட்ட பயன்படும்'},
  ];

  @override
  Widget build(BuildContext context) {
    var image = "https://deafapi.moodfor.codes/images/";
    return Scaffold(
      //key: _scaffoldKey,
      appBar: BaseAppBar(
        bacKText: "திரும்பிச் செல்",
        appBar: AppBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: CachedNetworkImage(
                height: 200,
                width: 280,
                imageUrl: image + widget.list['sign'],
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        "${widget.list['description']}",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: kPrimaryDarkColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    child: CachedNetworkImage(
                      height: 160,
                      // width: 160,
                      imageUrl: image + widget.list['image'],
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.contain),
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  )
                ],
              ),
            ),
            // Container(
            //   width: 280,
            //   child: Card(
            //     elevation: 0,
            //     child: Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Center(
            //         child: Text(
            //           "${widget.list['description']}",
            //           textAlign: TextAlign.left,
            //           style: TextStyle(
            //               color: kPrimaryDarkColor,
            //               fontSize: 20,
            //               fontWeight: FontWeight.bold),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 25),
            //   child: FutureBuilder(
            //     future: _initializeVideoPlayerFuture,
            //     builder: (context, snapshot) {
            //       if (snapshot.connectionState == ConnectionState.done) {
            //         return Center(
            //           child: AspectRatio(
            //             aspectRatio: _controller.value.aspectRatio,
            //             child: VideoPlayer(_controller),
            //           ),
            //         );
            //       } else {
            //         return Center(
            //           child: CircularProgressIndicator(),
            //         );
            //       }
            //     },
            //   ),
            // ),
            // SafeArea(
            //   child: Align(
            //     alignment: Alignment.bottomCenter,
            //     child: Padding(
            //       padding: const EdgeInsets.only(top: 0),
            //       child: ConstrainedBox(
            //         constraints: BoxConstraints.tightFor(
            //             width: screenWidth * 1.0, height: 75),
            //         child: FloatingActionButton(
            //           onPressed: () {
            //             setState(
            //               () {
            //                 if (_controller.value.isPlaying) {
            //                   _controller.pause();
            //                 } else {
            //                   _controller.play();
            //                 }
            //               },
            //             );
            //           },
            //           child: Icon(_controller.value.isPlaying
            //               ? Icons.pause
            //               : Icons.play_arrow),
            //         ),
            //       ),
            //       //   ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
