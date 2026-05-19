import 'package:flutter/foundation.dart';
import '../data/models/kuis_model.dart';
import '../data/repositories/kuis_repository.dart';

class KuisProvider with ChangeNotifier {
  final KuisRepository _repository = KuisRepository();

  List<SoalKuis> _soalAktif = [];
  int _currentIndex = 0;
  int _skor = 0;
  bool _isLoading = false;

  List<SoalKuis> get soalAktif => _soalAktif;
  int get currentIndex => _currentIndex;
  int get skor => _skor;
  bool get isLoading => _isLoading;
  bool get isSelesai => _soalAktif.isNotEmpty && _currentIndex >= _soalAktif.length;

  Future<void> mulaiKuis(int level) async {
    _isLoading = true;
    _currentIndex = 0;
    _skor = 0;
    notifyListeners();

    try {
      _soalAktif = await _repository.getSoalByLevel(level);
    } catch (e) {
      debugPrint("Error loading soal kuis: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void jawabSoal(String jawabanUser) {
    if (isSelesai) return;

    if (_soalAktif[_currentIndex].jawabanBenar == jawabanUser) {
      _skor += 10; // Asumsi 10 soal x 10 = max 100
    }
    
    _currentIndex++;
    notifyListeners();
  }

  void resetKuis() {
    _currentIndex = 0;
    _skor = 0;
    notifyListeners();
  }

  Future<void> simpanSkorAkhir(int userId, int level) async {
    await _repository.saveSkorKuis(userId, level, _skor, _soalAktif.length);
  }
  
  Future<int> getSkorTertinggi(int userId, int level) async {
      return await _repository.getSkorTertinggi(userId, level);
  }
}
