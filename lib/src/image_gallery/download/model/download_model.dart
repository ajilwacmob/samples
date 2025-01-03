class DownloadModel {
  final String title;
  final String thumbUrl;
  final String downloadUrl;
  final double totalMp;
  final double dowlodedMp;
  final String fileExtensionName;

  DownloadModel({
    required this.title,
    required this.thumbUrl,
    required this.downloadUrl,
    required this.totalMp,
    required this.dowlodedMp,
    required this.fileExtensionName,
  });
}

List<DownloadModel> downloadList = [
  DownloadModel(
    dowlodedMp: 1024,
    downloadUrl:
        "https://images.pexels.com/photos/2774551/pexels-photo-2774551.jpeg",
    fileExtensionName: ".mp4",
    thumbUrl:
        "https://images.pexels.com/photos/2774551/pexels-photo-2774551.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    title: "Worship",
    totalMp: 1024,
  ),
  DownloadModel(
    dowlodedMp: 100,
    downloadUrl:
        "https://images.pexels.com/photos/2372945/pexels-photo-2372945.jpeg",
    fileExtensionName: ".mp3",
    thumbUrl:
        "https://images.pexels.com/photos/2372945/pexels-photo-2372945.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    title: "Song",
    totalMp: 250,
  ),
  DownloadModel(
    dowlodedMp: 2,
    downloadUrl: "",
    fileExtensionName: ".jpg",
    thumbUrl:
        "https://images.pexels.com/photos/1652361/pexels-photo-1652361.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    title: "Boy Band in Concert",
    totalMp: 20,
  ),
  DownloadModel(
    dowlodedMp: 300,
    downloadUrl: "",
    fileExtensionName: ".pdf",
    thumbUrl:
        "https://images.pexels.com/photos/3943933/pexels-photo-3943933.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    title: "Title",
    totalMp: 400,
  ),
  DownloadModel(
    dowlodedMp: 1024,
    downloadUrl:
        "https://images.pexels.com/photos/2774551/pexels-photo-2774551.jpeg",
    fileExtensionName: ".mp4",
    thumbUrl:
        "https://images.pexels.com/photos/2774551/pexels-photo-2774551.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    title: "Worship",
    totalMp: 1024,
  ),
  DownloadModel(
    dowlodedMp: 100,
    downloadUrl:
        "https://images.pexels.com/photos/2372945/pexels-photo-2372945.jpeg",
    fileExtensionName: ".mp3",
    thumbUrl:
        "https://images.pexels.com/photos/2372945/pexels-photo-2372945.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    title: "Song",
    totalMp: 250,
  ),
  DownloadModel(
    dowlodedMp: 2,
    downloadUrl: "",
    fileExtensionName: ".jpg",
    thumbUrl:
        "https://images.pexels.com/photos/1652361/pexels-photo-1652361.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    title: "Boy Band in Concert",
    totalMp: 20,
  ),
  DownloadModel(
    dowlodedMp: 300,
    downloadUrl: "",
    fileExtensionName: ".pdf",
    thumbUrl:
        "https://images.pexels.com/photos/3943933/pexels-photo-3943933.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    title: "Title",
    totalMp: 400,
  ),
];
