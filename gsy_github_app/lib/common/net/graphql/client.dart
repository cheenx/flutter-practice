import 'package:graphql/client.dart';
import 'package:gsy_github_app/common/utils/common_utils.dart';

Future<GraphQLClient> _client(token) async {
  final HttpLink httpLink = HttpLink('https://api.github.com/graphql');
  final AuthLink authLink = AuthLink(getToken: () => '$token');
  final Link link = authLink.concat(httpLink);
  var path = await CommonUtils.getApplicationDocumentsPath();
  final store = await HiveStore.open(path: path);
  return GraphQLClient(link: link, cache: GraphQLCache(store: store));
}

GraphQLClient? _innerClient;

initClient(token) async {
  _innerClient ??= await _client(token);
}

releaseClient() {
  _innerClient = null;
}
