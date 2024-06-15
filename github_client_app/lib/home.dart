import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:github_client_app/common/git.dart';
import 'package:github_client_app/states/profile_change.dart';
import 'package:provider/provider.dart';
import 'package:github_client_app/models/index.dart';
import 'models/repo.dart';

class HomeRoute extends StatefulWidget {
  const HomeRoute({super.key});

  @override
  State<HomeRoute> createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  static const loadingTag = "##loading##";
  var _items = <Repo>[Repo()..name = loadingTag];
  bool hasMore = true; //是否还有数据
  int page = 1; //当前请求的是第几页

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(GmLocalizations.of(context).home),
      ),
      body: _buildBody(),
      drawer: MyDrawer(),
    );
  }

  Widget _buildBody() {
    UserModel userModel = Provider.of<UserModel>(context);
    if (!userModel.isLogin) {
      return Center(
        child: ElevatedButton(
          child: Text(GmLocalizations.of(context).login),
          onPressed: () => Navigator.of(context).pushNamed('login'),
        ),
      );
    } else {
      //已登录，则显示项目列表
      return ListView.separated(
          itemCount: _items.length,
          itemBuilder: (context, index) {
            //如果到了末尾
            if (_items[index].name == loadingTag) {
              //不足100条，继续获取数据
              if (hasMore) {
                //获取数据
                _retrieveData();
                //加载时显示loading
                return Container(
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 24.0,
                    height: 24.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                    ),
                  ),
                );
              } else {
                //已经加载了100条数据，不再获取数据
                return Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    '没有更多了',
                    style: TextStyle(color: Colors.grey),
                  ),
                );
              }

              return RepoItem(_items[index]);
            }
          },
          separatorBuilder: (context, index) => Divider(
                height: .0,
              ));
    }
  }

  void _retrieveData() async {
    var data = await Git(context)
        .getRepos(queryParamters: {"page": page, "page_size": 20});
    //如果返回的数据小于指定的条数，则表示没有更多数据，反之则否
    hasMore = data.length > 0 && data.length % 20 == 0;
    //把请求到的新数据添加到items中
    setState(() {
      _items.insertAll(_items.length - 1, data);
      page++;
    });
  }
}

class RepoItem extends StatefulWidget {
  RepoItem(this.repo) : super(key: ValueKey(repo.id));

  final Repo repo;

  @override
  State<RepoItem> createState() => _RepoItemState();
}

class _RepoItemState extends State<RepoItem> {
  @override
  Widget build(BuildContext context) {
    var subtitle;
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Material(
        color: Colors.white,
        shape: BorderDirectional(
            bottom:
                BorderSide(color: Theme.of(context).dividerColor, width: .5)),
        child: const Padding(
          padding: EdgeInsets.only(top: 0.0, bottom: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                dense: true,
                leading: gmAvatar(
                    //项目owner头像
                    widget.repo.owner.avatar_url,
                    width: 24.0,
                    borderRadius: BorderRadius.circular(12.0)),
                title: Text(
                  widget.repo.owner.login,
                  textScaleFactor: .9,
                ),
                subtitle: subTitle,
                trailing: Text(widget.repo.language ?? '--'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.repo.fork
                          ? widget.repo.full_name
                          : widget.repo.name,
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          fontStyle: widget.repo.fork
                              ? FontStyle.italic
                              : FontStyle.normal),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 8, bottom: 12),
                        child: widget.repo.description == null
                            ? Text(
                                GmLocalizations.of(context).noDescription,
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.grey[700]),
                              )
                            : Text(
                                widget.repo.description!,
                                maxLines: 3,
                                style: TextStyle(
                                    height: 1.15,
                                    color: Colors.blueGrey[700],
                                    fontSize: 13),
                              )),
                  ],
                ),
              )
              //构建卡片底部信息
              _buildBottom();
            ],
          ),
        ),
      ),
    );
  }

  //构建卡片底部信息
  Widget _buildBottom(){
    const paddingWidth = 10;
    return IconTheme(data: IconThemeData(
      color: Colors.grey,
      size: 15
    ), child: DefaultTextStyle(
      style: TextStyle(color: Colors.grey,fontSize: 12),
      child: Padding(padding: const EdgeInsets.symmetric(horizontal: 16.0),child: Builder(builder: (context){
        var children = <Widget>[
          Icon(Icons.star),
          Text(" " + widget.repo.stargazers_count.toString().padRight(paddingWidth)),
          Icon(Icons.info_outline),
          Text(" " + widget.repo.open_issues_count.toString().padRight(paddingWidth)),
          Icon(MyIcons.fork),
          Text(widget.repo.forks_count.toString().padRight(paddingWidth))
        ];
        if(widget.repo.fork){
          children.add(Text("Forked".padRight(paddingWidth)));
        }

        if(widget.repo.private == true){
          children.addAll(<Widget>[
            Icon(Icons.lock),
            Text(" private".padRight(paddingWidth))
          ]);
        }

        return Row(children: children,);
      }),),
    ));
  }
}

Widget gmAvatar(String url,{double width = 30,double? height,BoxFit? fit,BorderRadius? borderRadius}){
    var placeholder = Image.asset('imgs/avatar-default.png',width: width,height: height,);
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(2),
      child: CachedNetworkImage(
        imageUrl:url,
        width:width,
        height:height,
        fit:fit,
        placeholder:(context,url) => placeholder,
        errorWidget:(context,url,error) => placeholder
      ),
    );
  }

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(context: context,removeTop: true, child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          Expanded(child: _buildMenus())
        ],
      )),
    );
  }
}

Widget _buildHeader(){
    return Consumer(builder: (BuildContext context,UserModel value,Widget? child){
      return GestureDetector(
        child: Container(
          color: Theme.of(context).primaryColor,
          padding: EdgeInsets.only(top: 40,bottom: 20),
          child: Row(
            children: [
              Padding(padding: const EdgeInsets.symmetric(horizontal: 16.0),child: ClipOval(
                child: value.isLogin ? 
                gmAvatar(
                  value.user!.avatar_url,width: 80
                ) : 
                Image.asset('imgs/avatar-default.png',width: 80,),
              ),),
              Text(value.isLogin ? value.user!.login : GmLocalizations.of(context).login,style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),)
            ],
          ),
        ),
        onTap: () {
          if(!value.isLogin) Navigator.of(context).pushNamed('login');
        },
      );
    });
  }

Widget _buildMenus(){
  return Consumer(builder: (BuildContext context,UserModel userModel,Widget? child){
    var gm = GmLocalizations.of(context);
    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.color_lens),
          title: Text(gm.theme),
          onTap: () => Navigator.pushNamed(context,"themes"),
        ),
        ListTile(
          leading:const Icon(Icons.language),
          title: Text(gm.language),
          onTap: () => Navigator.pushNamed(context,"language"),
        ),
        if(userModel.isLogin)
          ListTile(
            leading: const Icon(Icons.power_settings_new),
            title: Text(gm.logout),
            onTap: (){
              showDialog(context: context, builder: (context){
                return AlertDialog(
                  content: Text(gm.logoutTip),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(context), child: Text(gm.cancel)),
                    TextButton(onPressed: () {
                      //该赋值语句触发MaterialApp rebuild
                      userModel.user = null;
                      Navigator.pop(context);
                    }, child: Text(gm.yes))
                  ],
                );
              });
            },
          )
      ],
    );
  });
}
