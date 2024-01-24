import 'package:flutter/material.dart';
import 'package:banner_carousel/banner_carousel.dart';
import 'package:wanandroid_1/services/blog_banner.dart';
import 'package:wanandroid_1/services/homeblog.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  List<BannerModel> banners = [];
  List<BlogContent> blogs = [];

  List<BannerModel> listBanners = [
    BannerModel(
        imagePath:
            'https://img1.baidu.com/it/u=371062527,221953162&fm=253&fmt=auto&app=120&f=JPEG?w=1280&h=800',
        id: '1'),
    BannerModel(
        imagePath:
            'https://img2.baidu.com/it/u=861863691,2776527252&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=500',
        id: '2'),
    BannerModel(
        imagePath:
            'https://img2.baidu.com/it/u=638285213,1746517464&fm=253&fmt=auto&app=120&f=JPEG?w=1422&h=800',
        id: '3'),
    BannerModel(
        imagePath:
            'https://img2.baidu.com/it/u=58915055,1355296400&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=500',
        id: '4'),
  ];

  void getBanners() async {
    BlogBanner banner = BlogBanner();
    List<BannerModel> bannersFromNetwork = await banner.getBanners();
    setState(() {
      banners = bannersFromNetwork;
    });
  }

  void getBlogList() async {
    HomeBlog homeBlog = HomeBlog();
    await homeBlog.getHomeBlog();
    setState(() {
      blogs = homeBlog.blogList;
    });
  }

  @override
  void initState() {
    super.initState();
    getBanners();

    getBlogList();
  }

  @override
  Widget build(BuildContext context) {
    banners = banners.isNotEmpty ? banners : List.empty();
    blogs = banners.isNotEmpty ? blogs : List.empty();

    return Column(
      children: [
        AppBar(
          backgroundColor: Colors.blue,
          elevation: 4.0,
          shadowColor: Colors.grey,
          centerTitle: true,
          title: Text(
            '博文',
            style: TextStyle(color: Colors.white),
          ),
        ),
        Expanded(child: HomeContent(banners, blogs)),
      ],
    );
  }
}

Widget BannerWidget(List<BannerModel> listBanners) {
  return BannerCarousel(
    banners: listBanners,
    customizedIndicators: IndicatorModel.animation(
        width: 20, height: 5, spaceBetween: 2, widthAnimation: 50),
    height: 130,
    activeColor: Colors.amberAccent,
    disableColor: Colors.white,
    animation: true,
    indicatorBottom: false,
    borderRadius: 0.0,
    margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
  );
}

Widget HomeContent(List<BannerModel> banners, List<BlogContent> blogs) {
  return Container(
    child: CustomScrollView(
      slivers: [
        // SliverToBoxAdapter for the Banner
        SliverToBoxAdapter(
          child: BannerWidget(banners),
        ),

        // SliverList for the scrollable list
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              // Your List Item Widget goes here
              return blogs.isNotEmpty
                  ? BlogItemCard(blogs[index])
                  : SizedBox.expand();
            },
            childCount: blogs.length, // Set the number of items in the list
          ),
        ),
      ],
    ),
  );
}

Widget BlogItemCard(BlogContent blog) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 6.0),
          Text(
            '${blog.title}',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.black),
          ),
          SizedBox(height: 6.0),
          Row(
            children: [Text('${blog.time} @${blog.author}')],
          ),
          SizedBox(height: 6.0),
          Row(
            children: [
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(4.0, 1.0, 4.0, 1.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.green, // 设置边框颜色
                        width: 1.0, // 设置边框宽度
                      ),
                      borderRadius: BorderRadius.circular(2.0)),
                  child: Text('${blog.superChapterName}')),
              SizedBox(
                width: 4.0,
              ),
              Text('${blog.superChapterName}/${blog.author}')
            ],
          ),
          SizedBox(height: 6.0),
        ],
      ),
    ),
  );
}
