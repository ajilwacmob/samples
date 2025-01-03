import 'package:flutter/foundation.dart';
import 'package:samples/src/posts/model/post_model.dart';

class PostViewModel extends ChangeNotifier {
  List<PostModel> posts = [
    PostModel(
      type: MsgType.video,
      data: {
        "is_following": false,
        "type": MsgType.video.name,
        "total_likes": 36363,
        "total_comments": 674,
        "total_reposts": 172,
        "is_comment_enabled": true,
        "post_likes": [
          {
            "user_name": "Ajil",
            "user_id": "72748327478324",
            "profile_img":
                "https://images.pexels.com/photos/810775/pexels-photo-810775.jpeg",
            "reaction_type": "like"
          },
          {
            "user_name": "Arun",
            "user_id": "72748327478323",
            "profile_img":
                "https://images.pexels.com/photos/2340978/pexels-photo-2340978.jpeg",
            "reaction_type": "happy"
          },
          {
            "user_name": "Ajil",
            "user_id": "72748327478324",
            "profile_img":
                "https://images.pexels.com/photos/810775/pexels-photo-810775.jpeg",
            "reaction_type": "like"
          },
        ],
        "video": {
          "url":
              "https://videos.pexels.com/video-files/27645916/12193996_2560_1440_25fps.mp4",
          "thumb_url":
              "https://images.pexels.com/photos/250591/pexels-photo-250591.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
          "length": 22,
          "title": null,
          "description": "Start Tracking All Your Money"
        },
        "company": {
          "place_holder_img":
              "https://s3-symbol-logo.tradingview.com/international-bus-mach--600.png",
          "company_name": "IBM",
          "total_followers": 53623563,
        }
      },
    ),
    PostModel(
      data: {
        "type": MsgType.image.name,
        "user_name": "Alexa",
        "bio": "I Wirte Code & Break Systems | Flutter Dev",
        "profile_level": 2,
        "post_availability": 1, //1 public
        "user_img":
            "https://www.isme.in/wp-content/uploads/2017/12/instructor4.jpg",
        "created_at": "12-11-2024T03:11:44",
        "images": [
          "https://images.pexels.com/photos/443446/pexels-photo-443446.jpeg",
          "https://images.pexels.com/photos/53141/rose-red-blossom-bloom-53141.jpeg",
          "https://images.pexels.com/photos/757889/pexels-photo-757889.jpeg",
          "https://images.pexels.com/photos/1187079/pexels-photo-1187079.jpeg",
          "https://images.pexels.com/photos/24778741/pexels-photo-24778741/free-photo-of-burning-lava-at-night.jpeg",
          "https://images.pexels.com/photos/757889/pexels-photo-757889.jpeg",
          "https://images.pexels.com/photos/1187079/pexels-photo-1187079.jpeg",
        ],
        "total_likes": 4,
        "total_comments": 4,
        "description":
            "Flowers are the reproductive structures of flowering plants (angiosperms) and are often admired for their beauty, fragrance, and vibrant colors. They play a crucial role in the reproductive cycle of plants, facilitating pollination and the production of seeds.",
        "is_comment_enabled": true,
        "post_likes": [
          {
            "user_name": "Ajil",
            "user_id": "72748327478324",
            "profile_img":
                "https://images.pexels.com/photos/810775/pexels-photo-810775.jpeg",
            "reaction_type": "like"
          },
          {
            "user_name": "Arun",
            "user_id": "72748327478323",
            "profile_img":
                "https://images.pexels.com/photos/2340978/pexels-photo-2340978.jpeg",
            "reaction_type": "happy"
          },
          {
            "user_name": "Ajil",
            "user_id": "72748327478324",
            "profile_img":
                "https://images.pexels.com/photos/810775/pexels-photo-810775.jpeg",
            "reaction_type": "like"
          },
          {
            "user_name": "Arun",
            "user_id": "72748327478323",
            "profile_img":
                "https://images.pexels.com/photos/2340978/pexels-photo-2340978.jpeg",
            "reaction_type": "happy"
          },
          {
            "user_name": "Ajil",
            "user_id": "72748327478324",
            "profile_img":
                "https://images.pexels.com/photos/810775/pexels-photo-810775.jpeg",
            "reaction_type": "like"
          },
          {
            "user_name": "Arun",
            "user_id": "72748327478323",
            "profile_img":
                "https://images.pexels.com/photos/2340978/pexels-photo-2340978.jpeg",
            "reaction_type": "happy"
          },
        ]
      },
      type: MsgType.image,
    ),
    PostModel(
      data: {
        "type": MsgType.jobs.name,
        "jobs": [
          {
            "company_name": "Apple",
            "company_id": "839483441",
            "place_holder_img":
                "https://www.zarla.com/images/apple-logo-2400x2400-20220512.png?crop=1:1,smart&width=150&dpr=2",
            "job_title": "Flutter Developer",
            "job_location": "Apple Park, California",
            "created_at": "12/12/2024T12:12:367Z"
          },
          {
            "company_name": "Google",
            "company_id": "839483442",
            "place_holder_img":
                "https://www.zarla.com/images/google-logo-2400x2400-20220519.png?crop=1:1,smart&width=150&dpr=2",
            "job_title": "Flutter Developer",
            "job_location": "Bangalore",
            "created_at": "12/12/2024T12:12:367Z"
          },
          {
            "company_name": "E-Bay",
            "company_id": "839483443",
            "place_holder_img":
                "https://www.zarla.com/images/ebay-logo-2400x2400-20220513-1.png?crop=1:1,smart&width=150&dpr=2",
            "job_title": "Flutter Developer",
            "job_location": "Bangalore",
            "created_at": "12/12/2024T12:12:367Z"
          },
          {
            "company_name": "Coca-Cola",
            "company_id": "839483444",
            "place_holder_img":
                "https://www.zarla.com/images/coca-cola-logo-2400x2400-20220513.png?crop=1:1,smart&width=150&dpr=2",
            "job_title": "Flutter Developer",
            "job_location": "Bangalore",
            "created_at": "12/12/2024T12:12:367Z"
          },
          {
            "company_name": "Disney",
            "company_id": "839483445",
            "place_holder_img":
                "https://www.zarla.com/images/disney-logo-2400x2400-20220513-2.png?crop=1:1,smart&width=150&dpr=2",
            "job_title": "Flutter Developer",
            "job_location": "Bangalore",
            "created_at": "12/12/2024T12:12:367Z"
          },
          {
            "company_name": "McDonald’s",
            "company_id": "839483446",
            "place_holder_img":
                "https://www.zarla.com/images/mcdonalds-logo-2400x2400-20220513-1.png?crop=1:1,smart&width=150&dpr=2",
            "job_title": "Flutter Developer",
            "job_location": "Bangalore",
            "created_at": "12/12/2024T12:12:367Z"
          },
          {
            "company_name": "Microsoft",
            "company_id": "839483447",
            "place_holder_img":
                "https://www.zarla.com/images/microsoft-logo-2400x2400-20223105.png?crop=1:1,smart&width=150&dpr=2",
            "job_title": "Flutter Developer",
            "job_location": "Bangalore",
            "created_at": "12/12/2024T12:12:367Z"
          },
          {
            "company_name": "Shell",
            "company_id": "839483448",
            "place_holder_img":
                "https://www.zarla.com/images/shell-logo-2400x2400-20220519-2.png?crop=1:1,smart&width=150&dpr=2",
            "job_title": "Flutter Developer",
            "job_location": "Bangalore",
            "created_at": "12/12/2024T12:12:367Z"
          },
          {
            "company_name": "Starbucks",
            "company_id": "839483449",
            "place_holder_img":
                "https://www.zarla.com/images/starbucks-logo-2400x2400-20220513.png?crop=1:1,smart&width=150&dpr=2",
            "job_title": "Flutter Developer",
            "job_location": "Bangalore",
            "created_at": "12/12/2024T12:12:367Z"
          },
          {
            "company_name": "Toyota",
            "company_id": "839483450",
            "place_holder_img":
                "https://www.zarla.com/images/toyota-logo-2400x2400-20220519-1.png?crop=1:1,smart&width=150&dpr=2",
            "job_title": "Flutter Developer",
            "job_location": "Bangalore",
            "created_at": "12/12/2024T12:12:367Z"
          },
          {
            "company_name": "BP",
            "company_id": "839483451",
            "place_holder_img":
                "https://www.zarla.com/images/bp-logo-2400x2400-20220518-1.png?crop=1:1,smart&width=150&dpr=2",
            "job_title": "Flutter Developer",
            "job_location": "Bangalore",
            "created_at": "12/12/2024T12:12:367Z"
          },
          {
            "company_name": "National Geographic",
            "company_id": "839483452",
            "place_holder_img":
                "https://www.zarla.com/images/national-geographic-logo-2400x2400-20223105.png?crop=1:1,smart&width=150&dpr=2",
            "job_title": "Flutter Developer",
            "job_location": "Bangalore",
            "created_at": "12/12/2024T12:12:367Z"
          },
          {
            "company_name": "Rolex",
            "company_id": "839483453",
            "place_holder_img":
                "https://www.zarla.com/images/rolex-logo-2400x2400-20223105-1.png?crop=1:1,smart&width=150&dpr=2",
            "job_title": "Flutter Developer",
            "job_location": "Bangalore",
            "created_at": "12/12/2024T12:12:367Z"
          },
        ]
      },
      type: MsgType.jobs,
    ),
    PostModel(
      data: {
        "type": MsgType.image.name,
        "user_name": "Max",
        "bio": "Wild Lfie PhotoGraphy | Nature",
        "profile_level": 2,
        "post_availability": 1, //1 public
        "user_img":
            "https://images.pexels.com/photos/326055/pexels-photo-326055.jpeg",
        "created_at": "12-11-2024T03:11:44",
        "images": [
          "https://images.pexels.com/photos/957024/forest-trees-perspective-bright-957024.jpeg",
          "https://images.pexels.com/photos/1547813/pexels-photo-1547813.jpeg",
        ],
        "total_likes": 4,
        "total_comments": 4,
        "description":
            "Flowers are the reproductive structures of flowering plants (angiosperms) and are often admired for their beauty, fragrance, and vibrant colors. They play a crucial role in the reproductive cycle of plants, facilitating pollination and the production of seeds.",
        "is_comment_enabled": true,
        "post_likes": [
          {
            "user_name": "Ajil",
            "user_id": "72748327478324",
            "profile_img":
                "https://images.pexels.com/photos/810775/pexels-photo-810775.jpeg",
            "reaction_type": "like"
          },
          {
            "user_name": "Arun",
            "user_id": "72748327478323",
            "profile_img":
                "https://images.pexels.com/photos/2340978/pexels-photo-2340978.jpeg",
            "reaction_type": "happy"
          },
          {
            "user_name": "Ajil",
            "user_id": "72748327478324",
            "profile_img":
                "https://images.pexels.com/photos/810775/pexels-photo-810775.jpeg",
            "reaction_type": "like"
          },
          {
            "user_name": "Arun",
            "user_id": "72748327478323",
            "profile_img":
                "https://images.pexels.com/photos/2340978/pexels-photo-2340978.jpeg",
            "reaction_type": "happy"
          },
          {
            "user_name": "Ajil",
            "user_id": "72748327478324",
            "profile_img":
                "https://images.pexels.com/photos/810775/pexels-photo-810775.jpeg",
            "reaction_type": "like"
          },
          {
            "user_name": "Arun",
            "user_id": "72748327478323",
            "profile_img":
                "https://images.pexels.com/photos/2340978/pexels-photo-2340978.jpeg",
            "reaction_type": "happy"
          },
        ]
      },
      type: MsgType.image,
    ),
  ];
}
