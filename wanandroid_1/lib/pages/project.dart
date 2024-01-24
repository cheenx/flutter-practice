import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:wanandroid_1/services/homeblog.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({super.key});

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  List<BlogContent> blogs = [];

  Future<List<ProjectCategory>> _fetchProjectCategories() async {
    // Replace this with your actual network request to fetch project categories
    Response response =
        await get(Uri.parse('https://www.wanandroid.com/project/tree/json'));
    Map<String, dynamic> body = JsonDecoder().convert(response.body);
    List<ProjectCategory> data = [];
    for (var cate in body['data']) {
      data.add(ProjectCategory(
          id: cate['id'], name: cate['name'], isVisible: cate['visible'] == 0));
    }
    return data;
  }

  Future<List<String>> _fetchProjectsForCategory(
      ProjectCategory? category) async {
    // Replace this with your actual network request to fetch projects for the selected category
    if (category == null) return List.empty();

    Response response = await get(Uri.parse(
        'https://www.wanandroid.com/project/list/1/json?cid=${category.id}'));
    Map<String, dynamic> data = JsonDecoder().convert(response.body);
    return List.generate(10, (index) => '$category 项目 $index');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    blogs = blogs.isNotEmpty ? blogs : List.empty();
    return Column(
      children: [
        AppBar(
          backgroundColor: Colors.blue,
          elevation: 4.0,
          shadowColor: Colors.grey,
          centerTitle: true,
          title: Text(
            '项目',
            style: TextStyle(color: Colors.white),
          ),
        ),
        FutureBuilder<List<ProjectCategory>>(
          future: _fetchProjectCategories(),
          builder: (context, snapshot) {
            if (snapshot.hasData || snapshot.data?.isNotEmpty == true) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: snapshot.data!.map((ProjectCategory category) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle category selection here
                          _fetchAndLoadProjectsForCategory(category);
                        },
                        child: Text('${category.name}'),
                      ),
                    );
                  }).toList(),
                ),
              );
            } else {
              return Container();
            }
          },
        ),
        Expanded(
          child: FutureBuilder<List<String>>(
            // Provide the selected category to fetch projects
            future: _fetchProjectsForCategory(selectedCategory),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error loading projects'));
              } else if (!snapshot.hasData || snapshot.data?.isEmpty == true) {
                return Center(
                    child: Text(
                        'No projects available for the selected category'));
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(snapshot.data![index]),
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }

  ProjectCategory? selectedCategory; // Store the selected category

  Future<void> _fetchAndLoadProjectsForCategory(
      ProjectCategory category) async {
    setState(() {
      selectedCategory = category;
    });
  }
}

Widget ProjectContent(ProjectCategory category) {
  return CustomScrollView(
    slivers: [
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            // Your List Item Widget goes here
            return ProjectItemCard(category);
          },
          childCount: 1, // Set the number of items in the list
        ),
      ),
    ],
  );
}

Widget ProjectItemCard(ProjectCategory project) {
  return Card();
}

class ProjectCategory {
  int id = -1;
  String? name = '';
  bool? isVisible = false;

  ProjectCategory({required this.id, this.name, this.isVisible});
}
