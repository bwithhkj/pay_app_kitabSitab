
class Book {

  String bookURL;
  String name;
  DateTime uploadDate;
  String location;
  String user;
  String category;
  int amount;
  String contact;

  Book(
      this.bookURL,
      this.name,
      this.uploadDate,
      this.location,
      this.user,
      this.category,
      this.amount,
      this.contact,
      );

  Book.empty();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> book = Map();
    book['bookURL'] = bookURL;
    book['name'] = name;
    book['uploadDate'] = uploadDate;
    book['Location'] = location?? 'not available';
    book['user'] = user;
    book['category'] =  category;
    book['amount']= amount;
    book['contact'] = contact;
    return book;
  }

  Book.fromMap(Map<String, dynamic> map) {
    this.name = map['name'];
    this.bookURL = map['bookURL'];
    this.name = map['name'];
    this.uploadDate = map['uploadDate'];
    this.location = map['location'];
    this.user = map['user'];
    this.category = map['category'];
    this.amount = map['amount'];
    this.contact = map['contact'];
  //  this.user = map['user']['name']l;
  }
}