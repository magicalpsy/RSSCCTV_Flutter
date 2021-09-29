import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:netflix_application/model/model_cctv.dart';

class RtspScreen extends StatefulWidget {
  final Movie movie;
  RtspScreen({required this.movie});
  _RtspScreenState createState() => _RtspScreenState();
}

class _RtspScreenState extends State<RtspScreen> {
  late VlcPlayerController _videoPlayerController;
  // This widget is the root of your application.
  @override
  void initState() {
    super.initState();

    _videoPlayerController = VlcPlayerController.network(
      widget.movie.cctv_url,
      // 'rtsp://ktkw:kw0348@175.206.237.71:554/stream_ch00_1',
      // 'https://media.w3.org/2010/05/sintel/trailer.mp4',
      // "rtsp://175.206.237.71:554/user=ktkw&password=&kw0348&channel=0&stream=1.sdp?",
      // cvlc "rtsp://192.168.20.100:554/user=admin&password=&channel=1&stream=0.sdp?"
      // 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      // 'http://distribution.bbb3d.renderfarming.net/video/mp4/bbb_sunflower_1080p_60fps_normal.mp4',
      // 'rtsp://ktkw:kw0348@yongjun.iptimecam.com:554/stream_ch00_1',
      hwAcc: HwAcc.FULL,
      options: VlcPlayerOptions(
        advanced: VlcAdvancedOptions([
          VlcAdvancedOptions.networkCaching(2000),
        ]),
        subtitle: VlcSubtitleOptions([
          VlcSubtitleOptions.boldStyle(true),
          VlcSubtitleOptions.fontSize(30),
          VlcSubtitleOptions.outlineColor(VlcSubtitleColor.yellow),
          VlcSubtitleOptions.outlineThickness(VlcSubtitleThickness.normal),
          // works only on externally added subtitles
          VlcSubtitleOptions.color(VlcSubtitleColor.navy),
        ]),
        rtp: VlcRtpOptions([
          VlcRtpOptions.rtpOverRtsp(true),
        ]),
        // VlcRtpOptions
      ),
    );
  }

  @override
  void dispose() async {
    super.dispose();
    await _videoPlayerController.stopRendererScanning();
    await _videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: VlcPlayer(
          controller: _videoPlayerController,
          aspectRatio: 16 / 9,
          placeholder: Center(child: CircularProgressIndicator()),
        ),
      ),
    );
    // return Scaffold(
    //   body: Container(
    //     child:
    //     RtspPlay(),
    //   ),
    // );

    // return MaterialApp(
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //     visualDensity: VisualDensity.adaptivePlatformDensity,
    //   ),
    //   home: MyHomePage(),
    // );
  }
}

class RtspPlay extends StatefulWidget {
  RtspPlay({Key? key}) : super(key: key);

  @override
  _RtspPlayState createState() => _RtspPlayState();
}

class _RtspPlayState extends State<RtspPlay> {
  late VlcPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();

    _videoPlayerController = VlcPlayerController.network(
      // widget,
      'rtsp://ktkw:kw0348@175.206.237.71:554/stream_ch00_1',
      // 'https://media.w3.org/2010/05/sintel/trailer.mp4',
      // "rtsp://175.206.237.71:554/user=ktkw&password=&kw0348&channel=0&stream=1.sdp?",
      // cvlc "rtsp://192.168.20.100:554/user=admin&password=&channel=1&stream=0.sdp?"
      // 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      // 'http://distribution.bbb3d.renderfarming.net/video/mp4/bbb_sunflower_1080p_60fps_normal.mp4',
      // 'rtsp://ktkw:kw0348@yongjun.iptimecam.com:554/stream_ch00_1',
      hwAcc: HwAcc.FULL,
      options: VlcPlayerOptions(
        advanced: VlcAdvancedOptions([
          VlcAdvancedOptions.networkCaching(2000),
        ]),
        subtitle: VlcSubtitleOptions([
          VlcSubtitleOptions.boldStyle(true),
          VlcSubtitleOptions.fontSize(30),
          VlcSubtitleOptions.outlineColor(VlcSubtitleColor.yellow),
          VlcSubtitleOptions.outlineThickness(VlcSubtitleThickness.normal),
          // works only on externally added subtitles
          VlcSubtitleOptions.color(VlcSubtitleColor.navy),
        ]),
        rtp: VlcRtpOptions([
          VlcRtpOptions.rtpOverRtsp(true),
        ]),
        // VlcRtpOptions
      ),
    );
  }

  @override
  void dispose() async {
    super.dispose();
    await _videoPlayerController.stopRendererScanning();
    await _videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: VlcPlayer(
          controller: _videoPlayerController,
          aspectRatio: 16 / 9,
          placeholder: Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
