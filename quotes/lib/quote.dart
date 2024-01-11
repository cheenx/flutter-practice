/**
 * first define method
 */
// class Quote {
//   String? text;
//   String? author;
//
//   Quote(String text, String author) {
//     this.text = text;
//     this.author = author;
//   }
// }
//
// Quote myQuote = Quote('this is a quote text', 'Oscar wilde');

/**
 * second define method
 */
// class Quote {
//   String? text;
//   String? author;
//
//   Quote({String? text, String? author}) {
//     this.text = text;
//     this.author = author;
//   }
// }
//
// Quote myQuote = Quote(text: 'this is a quote text', author: 'Oscar wilde');

/**
 * third define method
 */
class Quote {
  String? text;
  String? author;

  Quote({this.text, this.author});
}

Quote myquote = Quote(author: 'Oscar Wilde', text: 'this is a quote text');
