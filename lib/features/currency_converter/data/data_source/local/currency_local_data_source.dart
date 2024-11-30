import 'package:dartz/dartz.dart';
import 'package:sqflite/sqflite.dart';
import 'package:currency_converter/core/utils/typedef.dart';
import 'package:currency_converter/core/error_handling/failure.dart';
import 'package:currency_converter/core/local_database/cache_manager.dart';
import 'package:currency_converter/core/local_database/database_manager.dart';
import 'package:currency_converter/features/currency_converter/data/models/currency_model.dart';

abstract class CurrencyLocalDataSource {
  FutureResult<CurrencyModel> getCurrencyList();
  Future<void> saveCurrencies(CurrencyModel currencies);
}

class CurrencyLocalDataSourceImplementation implements CurrencyLocalDataSource {
  static const String _tableName = 'currencies';

  final DatabaseManager databaseManager;
  final CacheManager cacheManager;

  CurrencyLocalDataSourceImplementation({
    required this.databaseManager,
    required this.cacheManager,
  });

  @override
  FutureResult<CurrencyModel> getCurrencyList() async {
    try {
      final db = await databaseManager.database;
      final result = await db.query(_tableName);

      if (result.isEmpty) {
        return const Left(Failure(
          title: "Error",
          message: "No data found in cache. Please fetch from the server.",
        ));
      }

      final cacheTimestamp = result.first['timestamp'] as int;

      if (cacheManager.isCacheExpired(cacheTimestamp)) {
        return const Left(Failure(
          title: "Cache Expired",
          message:
              "The cached data is older than the allowed duration, fetch new data from the server.",
        ));
      }

      final data = {
        for (var row in result) row['code'] as String: row['rate'] as double,
      };
      return Right(CurrencyModel(data: data));
    } catch (e) {
      return Left(Failure(
          title: "Error",
          message: 'Failed to fetch currencies from local database: $e'));
    }
  }

  @override
  Future<void> saveCurrencies(CurrencyModel currency) async {
    try {
      final db = await databaseManager.database;
      final currentTimestamp = DateTime.now().millisecondsSinceEpoch;

      await db.delete(_tableName);

      final batch = db.batch();
      currency.data.forEach((code, rate) {
        batch.insert(
          _tableName,
          {
            "code": code,
            "rate": rate,
            "timestamp": currentTimestamp,
          },
          conflictAlgorithm: ConflictAlgorithm.replace, // Replace existing data
        );
      });

      await batch.commit(noResult: true);
    } catch (e) {
      throw Failure(
        title: "Error",
        message: 'Failed to save currencies: $e',
      );
    }
  }
}
