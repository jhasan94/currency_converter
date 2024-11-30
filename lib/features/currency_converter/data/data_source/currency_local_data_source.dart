import 'package:currency_converter/core/error_handling/failure.dart';
import 'package:currency_converter/core/local_database/database_manager.dart';
import 'package:currency_converter/core/utils/typedef.dart';
import 'package:currency_converter/features/currency_converter/data/models/currency_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:dartz/dartz.dart';

abstract class CurrencyLocalDataSource {
  FutureResult<CurrencyModel> getCurrencyList();
  Future<void> saveCurrencies(CurrencyModel currencies);
}

class CurrencyLocalDataSourceImplementation implements CurrencyLocalDataSource {
  static const String _tableName = 'currencies';

  final DatabaseManager databaseManager;
  CurrencyLocalDataSourceImplementation({required this.databaseManager});

  @override
  FutureResult<CurrencyModel> getCurrencyList() async {
    try {
      final database = await databaseManager.database;
      final result = await database.query(_tableName);
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
      final database = await databaseManager.database;
      final batch = database.batch();
      currency.data.forEach((code, rate) {
        batch.insert(
          _tableName,
          {
            "code": code,
            "rate": rate,
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
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
