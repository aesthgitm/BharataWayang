import 'package:flutter/foundation.dart';
import '../data/models/kartu_wayang_model.dart';
import '../data/models/koleksi_model.dart';
import '../data/repositories/wayang_repository.dart';

class KoleksiProvider with ChangeNotifier {
  final WayangRepository _repository = WayangRepository();

  List<KartuWayang> _semuaKartu = [];
  List<UserKoleksi> _koleksiUser = [];
  bool _isLoading = false;

  List<KartuWayang> get semuaKartu => _semuaKartu;
  List<UserKoleksi> get koleksiUser => _koleksiUser;
  bool get isLoading => _isLoading;

  Future<void> loadData(int userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _semuaKartu = await _repository.getAllKartuWayang();
      _koleksiUser = await _repository.getKoleksiUser(userId);
    } catch (e) {
      debugPrint("Error loading koleksi data: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  bool isKartuUnlocked(int kartuId) {
    return _koleksiUser.any((k) => k.kartuId == kartuId);
  }

  Future<void> unlockKartu(int userId, int kartuId) async {
    await _repository.unlockKartu(userId, kartuId);
    // Reload koleksi setelah unlock
    await loadData(userId);
  }
}
