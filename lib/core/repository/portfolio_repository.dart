import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:portfolio/core/models/portfolio_model.dart';

class PortfolioRepository {
  PortfolioData? _portfolioData;

  Future<PortfolioData> getPortfolioData() async {
    if (_portfolioData != null) return _portfolioData!;

    final String jsonString =
        await rootBundle.loadString('assets/data/portfolio.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    _portfolioData = PortfolioData.fromJson(jsonMap);
    return _portfolioData!;
  }
}
