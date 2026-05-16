import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'kuafor_veritabani.db');
    return await openDatabase(path, version: 2, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE kullanicilar(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        kullaniciAdi TEXT,
        telefonNo TEXT,
        ePosta TEXT,
        sifre TEXT,
        rol TEXT
      )
    ''');

    await db.insert('kullanicilar', {
      'kullaniciAdi': 'Yönetici Kübra',
      'telefonNo': '05556667788',
      'ePosta': 'yonetici@kuafor.com',
      'sifre': 'kubra05',
      'rol': 'yönetici',
    });

    await db.insert('kullanicilar', {
      'kullaniciAdi': 'Müşteri Selin',
      'telefonNo': '05558889911',
      'ePosta': 'selin@mail.com',
      'sifre': 'selin52',
      'rol': 'müşteri',
    });

    await db.execute('''
      CREATE TABLE hizmetler(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        kategoriTuru TEXT,
        hizmetAdi TEXT,
        fiyat TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE randevular(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        kullaniciId INTEGER,
        secilenHizmet TEXT,
        tarih TEXT,
        saat TEXT,
        tutar REAL,
        odemeDurum INTEGER,
        FOREIGN KEY (kullaniciId) REFERENCES kullanicilar (id)
      )
    ''');

    await db.execute('''
  CREATE TABLE loglar(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    islem TEXT,
    kullanici TEXT,
    tarih TEXT
  )
''');
  }

  Future<List<Map<String, dynamic>>> verileriGetir(String tabloAdi) async {
    final db = await database;
    return await db.query(tabloAdi);
  }

  Future<int> kullaniciyiKaydet(Map<String, dynamic> kullanici) async {
    final db = await database;
    return await db.insert('kullanicilar', kullanici);
  }

  Future<List<Map<String, dynamic>>> loglariGetir() async {
    final db = await database;

    return await db.query('loglar', orderBy: 'id DESC');
  }

  Future<void> logKaydet(String islem, String kullanici) async {
    final db = await database;
    await db.insert('loglar', {
      'islem': islem,
      'kullanici': kullanici,
      'tarih': DateTime.now().toString(),
    });
  }

  Future<Map<String, dynamic>?> kullanicibulGetir(String? telNo) async {
    if (telNo == null || telNo.isEmpty) return null;

    final db = await database;
    String yeniTel = telNo;

    if (yeniTel.startsWith('+90')) {
      yeniTel = '0' + yeniTel.substring(3);
    } else if (!yeniTel.startsWith('0') && yeniTel.length == 10) {
      yeniTel = '0' + yeniTel;
    }

    List<Map<String, dynamic>> sonuc = await db.query(
      'kullanicilar',
      where: 'telefonNo = ?',
      whereArgs: [yeniTel],
    );
    if (sonuc.isNotEmpty) {
      return sonuc.first;
    }
    return null;
  }

  Future<Map<String, dynamic>?> kullaniciGirisBilgisiGetir(
    String? girdi,
  ) async {
    if (girdi == null || girdi.isEmpty) return null;

    final db = await database;

    List<Map<String, dynamic>> sonuc = await db.query(
      'kullanicilar',
      where: 'telefonNo = ? OR ePosta = ?',
      whereArgs: [girdi, girdi],
    );

    if (sonuc.isNotEmpty) {
      return sonuc.first;
    }
    return null;
  }

  Future<int> randevuyuKaydet(Map<String, dynamic> randevu) async {
    final db = await database;
    return await db.insert('randevular', randevu);
  }

  Future<List<Map<String, dynamic>>> kullaniciRandevulariGetir(
    int kullaniciId,
  ) async {
    final db = await database;
    return await db.query(
      'randevular',
      where: 'kullaniciId=?',
      whereArgs: [kullaniciId],
      orderBy: 'id DESC',
    );
  }

  Future<int> randevuSil(int id) async {
    final db = await database;
    return await db.delete('randevular', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> tumRandevulariGetir() async {
    final db = await database;
    return await db.query('randevular', orderBy: 'id DESC');
  }

  Future<int> odemeDurumGuncelle(int randevuID) async {
    final db = await database;
    return await db.update(
      'randevular',
      {'odemeDurum': 1},
      where: 'id = ?',
      whereArgs: [randevuID],
    );
  }

  Future<int> sifreUnutGuncelle(String telNo, String yeniSifre) async {
    final db = await database;
    return await db.update(
      'kullanicilar',
      {'sifre': yeniSifre},
      where: 'telefonNo = ?',
      whereArgs: [telNo],
    );
  }
}
