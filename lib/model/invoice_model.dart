class Invoice {
  final InvoiceInfo info;
  final Supplier supplier;
  final Customer customer;
  final List<InvoiceItem> items;

  const Invoice(
      {required this.info,
      required this.supplier,
      required this.customer,
      required this.items});
}

class InvoiceInfo {
  final String description;
  final String number;
  final DateTime date;
  final DateTime dueDate;

  const InvoiceInfo(
      {required this.description,
      required this.date,
      required this.dueDate,
      required this.number});
}

class Supplier {
  final String name;
  final String address;
  final String mobile;

  const Supplier(
      {required this.address, required this.mobile, required this.name});
}

class Customer {
  final String name;
  final String address;
  final String mobile;

  const Customer(
      {required this.address, required this.mobile, required this.name});
}

class InvoiceItem {
  final String name;
  final String description;
  final String qty;
  final String price;
  final DateTime date;

  const InvoiceItem(
      {required this.name,
      required this.date,
      required this.description,
      required this.price,
      required this.qty});
}
