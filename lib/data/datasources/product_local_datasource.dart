import 'package:possapp/data/models/request/order_request_model.dart';
import 'package:possapp/data/models/response/product_response_model.dart';
import 'package:possapp/presentation/home/models/order_item.dart';
import 'package:possapp/presentation/orders/models/order_models.dart';
import 'package:sqflite/sqflite.dart';

class ProductLocalDatasource {
  ProductLocalDatasource._init();

  static final ProductLocalDatasource instance = ProductLocalDatasource._init();

  final String tableProducts = 'produks';

  static Database? _database;

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = dbPath + filePath;

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  //database yg dibuat dilokal tdk harus sama dgn yg di laravel
  // karna ini hanya untuk kebutuhan lokal
  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableProducts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        product_id INTEGER,
        name TEXT,
        price INTEGER,
        stock INTEGER,
        image TEXT,
        category TEXT,
        is_best_seller INTEGER,
        is_sync INTEGER DEFAULT 0
      )
    ''');

    await db.execute('''
      CREATE TABLE orders (
         id INTEGER PRIMARY KEY AUTOINCREMENT,
        nominal INTEGER,
        payment_method TEXT,
        total_item INTEGER,
        id_kasir INTEGER,
        nama_kasir TEXT,
        transaction_time TEXT,
        is_sync INTEGER DEFAULT 0
      )
    ''');

    await db.execute('''
      CREATE TABLE order_item (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        id_order INTEGER,
        id_product INTEGER,
        quantity INTEGER,
        price INTEGER
      )
    ''');
  }

  // Save Order
  Future<int> saveOrder(OrderModel order) async {
    final db = await instance.database;  //instance; ibarat masuk. misal masuk ke database
    int id = await db.insert('orders', order.toMapForLocal());
    for (var orderItem in order.orders) {
      await db.insert('order_item', orderItem.toMapForLocal(id));
    }
    return id;
  }

  // get order by isSync = 0
  Future<List<OrderModel>> getOrderByIsSync() async {
    final db = await instance.database;
    final result = await db.query('orders', where: 'is_sync = 0');

    return result.map((e) => OrderModel.fromLocalMap(e)).toList();
  }

  // get all orders
  Future<List<OrderModel>> getAllOrder() async {
    final db = await instance.database;
    final result = await db.query('orders', orderBy: 'id DESC');
    return result.map((e) => OrderModel.fromLocalMap(e)).toList();
  }

  // get order item by id order
  Future<List<OrderItem>> getOrderItemByOrderId(int idOrder) async {
    final db = await instance.database;
    final result = await db.query('order_item', where: 'id_order = $idOrder');
    return result.map((e) => OrderItem.fromMap(e)).toList();
  }

  // get order item by id order lokal
  Future<List<OrderItemModel>> getOrderItemByOrderIdLocal(int idOrder) async {
    final db = await instance.database;
    final result = await db.query('order_item', where: 'id_order = $idOrder');
    return result.map((e) => OrderItem.fromMapLocal(e)).toList();
  }

  // Update isSync order by id
  Future<int> updateIsSyncOrderById(int id) async {
    final db = await instance.database;
    return await db.update('orders', {'is_sync': 1},
        where: 'id = ?', whereArgs: [id]);
  }

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('posappp4.db');
    return _database!;
  }

  //remove all data product
  Future<void> removeAllProduct() async {
    final db = await instance.database;
    await db.delete(tableProducts);
  }

  //insert data product from list product
  Future<void> insertAllProduct(List<Product> products) async {
    final db = await instance.database;
    for (var product in products) {
      await db.insert(tableProducts, product.toLocalMap());
    }
  }

  //isert data product
  Future<Product> insertProduct(Product product) async {
    final db = await instance.database;
    int id = await db.insert(tableProducts, product.toMap());
    return product.copyWith(id: id);
  }

  //get all data product
  Future<List<Product>> getAllProduct() async {
    final db = await instance.database;
    final result = await db.query(tableProducts);

    return result.map((e) => Product.fromMap(e)).toList();
  }
}
