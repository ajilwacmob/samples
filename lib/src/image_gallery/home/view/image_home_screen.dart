import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samples/common_widget/common_image_widget.dart';
import 'package:samples/common_widget/switch_state_widget.dart';
import 'package:samples/src/image_gallery/details/view/image_details_screen.dart';
import 'package:samples/src/image_gallery/home/model/image_model.dart';
import 'package:samples/src/image_gallery/home/view_model/image_view_model.dart';
import 'package:samples/utils/common_functions.dart';
import 'package:samples/utils/extension.dart';
import 'package:samples/utils/loader_states.dart';
import 'package:tuple/tuple.dart';

class ImageListHomeScreen extends StatefulWidget {
  const ImageListHomeScreen({super.key});

  @override
  State<ImageListHomeScreen> createState() => _ImageListHomeScreenState();
}

class _ImageListHomeScreenState extends State<ImageListHomeScreen>
    with AutomaticKeepAliveClientMixin {
  ImageModel? imageModel;

  @override
  void initState() {
    afterInit(_init);

    super.initState();
  }

  _init() async {
    await context
        .read<ImageViewModel>()
        .getImages(query: "&q=Porsche")
        .then((value) {
      imageModel = value;
      context.read<ImageViewModel>().update();
    });
  }

  final List<String> categoryNames = [
    "Electronics",
    "Anime",
    "Clothing",
    "Books",
    "Home Appliances",
    "Moon",
    "Galaxy",
    "Trees",
    "Trains",
    "Sun",
    "Animals",
    "People",
    "Birds",
    "Kids",
    "Women",
    "Men",
    "Mobile Phones",
    "Bikes",
    "Motor Cycles",
    "Rose",
    "Rose Bouquet",
    "Beauty",
    "Toys",
    "Furniture",
    "Sports",
    "Accessories",
    "Groceries",
    "Jewelry",
    "Health",
    "Automotive",
    "Flowers",
    "Mobile Wallpapers",
    "Cars",
    "Mountains",
    "Hollywood"
  ];

  ///storage/emulated/0/Android/data/com.example.samples/files/sample/test_2.jpeg

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var size = MediaQuery.of(context).size;

    return SafeArea(
      top: false,
      child: Scaffold(
        /*  
         floatingActionButton: FloatingActionButton(
          onPressed: () async {
            var downloadHelperProvider =
                context.read<DownloadHelperViewModel>();
            String url =
                "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4";
            String fileName = "893283283";
            bool isExist =
                await downloadHelperProvider.checkFileExists(url, fileName,true);
            if (!isExist) {
              downloadHelperProvider.downloadFile(url, fileName);
            }
          },
          child: const Icon(Icons.folder_open),),
         */
        appBar: AppBar(
          title: const Text("Image Gallery"),
          elevation: 1,
          actions: [
            PopupMenuButton(itemBuilder: (_) {
              return categoryNames
                  .map((e) => PopupMenuItem<String>(
                      onTap: () {
                        context
                            .read<ImageViewModel>()
                            .getImages(query: "&q=$e")
                            .then((value) {
                          imageModel = value;
                          context.read<ImageViewModel>().update();
                        });
                      },
                      child: Text(e)))
                  .toList();
            })
          ],
        ),
        body: Selector<ImageViewModel, Tuple2<LoaderState, String?>>(
          selector: (_, selector) =>
              Tuple2(selector.getImageLoaderState, selector.errorMessage),
          builder: (_, provider, __) {
            return SwitchStateWidget(
              loaderState: provider.item1,
              isRequiredSystemHeight: true,
              loadAgain: _init,
              errorMessage: provider.item2,
              child: SizedBox(
                width: size.width,
                height: size.height,
                child: RefreshIndicator(
                  onRefresh: () async {
                    _init();
                  },
                  child: GridView.builder(
                    itemCount: imageModel?.hits?.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 1,
                            mainAxisSpacing: 1,
                            crossAxisCount: 3,
                            childAspectRatio: 100 / 150),
                    itemBuilder: (_, index) {
                      Hits? imageData = imageModel?.hits?[index];
                      return ImageWidget(
                        imageData: imageData,
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class ImageWidget extends StatelessWidget {
  final Hits? imageData;
  const ImageWidget({super.key, this.imageData});
  final String url =
      "https://pixabay.com/get/g8d89b341eb235b69b2068bca166a90fdc4ce0c5eb707ed9fc25d30cf68a4b89e31eb7d14edcc85d691b0c6a85ec76f2d_640.jpg";

  @override
  Widget build(BuildContext context) {
    final heroId = DateTime.now().microsecondsSinceEpoch + (imageData?.id ?? 0);
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (_) => ImageDetailsScreen(
              imageData: imageData,
              heroId: heroId,
            ),
          ),
        );
      },
      child: Stack(
        children: [
          Hero(
            tag: "$heroId",
            child: CommonImageWidget(
              imgUrl: imageData?.largeImageURL ?? url,
              width: 150,
              height: 200,
            ),
          ),
          Container(
            decoration:
                const BoxDecoration(color: Color.fromARGB(66, 56, 46, 46)),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(color: Colors.black54),
              child: Row(
                children: [
                  CommonImageWidget(
                    imgUrl: imageData?.userImageURL ?? url,
                    width: 20,
                    height: 20,
                    radius: 100,
                    showLoader: false,
                    showBorder: true,
                    borderWidth: 1,
                  ),
                  const Spacer(),
                  const SizedBox(
                    width: 5,
                  ),
                  const Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 12,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Text(
                    (imageData?.likes?.toString() ?? "0").convertValue(),
                    style: TextStyle(
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w500,
                        fontSize: 10),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Icon(
                    Icons.remove_red_eye,
                    color: Colors.grey,
                    size: 12,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Text(
                    (imageData?.views?.toString() ?? "0").convertValue(),
                    style: TextStyle(
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w500,
                        fontSize: 10),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
