import 'dart:convert';

import 'package:http/http.dart';

class HomeBlog {
  String currentPage = '0';
  List<BlogContent> blogList = [];

  Future<void> getHomeBlog() async {
    Response response = await get(
        Uri.parse('https://www.wanandroid.com/article/list/$currentPage/json'));
    // print(response.body);
    Map<String, dynamic> map = JsonDecoder().convert(response.body);
    Map<String, dynamic> data = map['data'];
    List<dynamic> datas = data['datas'];
    // print(datas);

    for (var item in datas) {
      blogList.add(BlogContent(
          id: item['id'],
          title: convertHtmlEntityToUnicode(item['title']),
          author: item['author'],
          time: item['niceDate'],
          superChapterId: '${item['superChapterId']}',
          superChapterName: item['superChapterName'],
          url: item['link']));
    }
    print(blogList[3].author);
  }
}

class BlogContent {
  String? title = '';
  String? time = '';
  String? author = '';
  String? url = '';
  String? superChapterName = '';
  String? superChapterId = '';
  int id = -1;

  BlogContent(
      {required this.id,
      this.title,
      this.author,
      this.time,
      this.superChapterId,
      this.superChapterName,
      this.url});
}

String convertHtmlEntityToUnicode(String htmlEntity) {
  String unicodeString = '';
  // 解析 HTML 实体字符的 Unicode
  final RegExp exp = RegExp(r'&[^;]+;');
  htmlEntity = htmlEntity.replaceAllMapped(exp, (match) {
    String? entity = match.group(0);
    if (entity == '&mdash;') {
      return '—'; // 替换为短破折号的 Unicode
    } else {
      return entity ?? '';
    }
  });

  // 将字符串中的 HTML 实体字符转换为 Unicode
  for (int i = 0; i < htmlEntity.runes.length; ++i) {
    unicodeString += String.fromCharCode(htmlEntity.runes.elementAt(i));
  }

  return unicodeString;
}
