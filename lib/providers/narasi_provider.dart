import 'package:flutter/foundation.dart';
import '../data/models/serat_model.dart';
import '../data/models/progres_narasi_model.dart';
import '../data/models/faq_model.dart';
import '../data/repositories/serat_repository.dart';

class NarasiProvider with ChangeNotifier {
  final SeratRepository _repository = SeratRepository();

  List<ProgresNarasi> _progresUser = [];
  List<FaqMahabharata> _listFaq = [];
  List<SeratMahabharata> _parwaAktif = [];
  bool _isLoading = false;

  List<ProgresNarasi> get progresUser => _progresUser;
  List<FaqMahabharata> get listFaq => _listFaq;
  List<SeratMahabharata> get parwaAktif => _parwaAktif;
  bool get isLoading => _isLoading;

  Future<void> loadProgres(int userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _progresUser = await _repository.getProgresMembaca(userId);
    } catch (e) {
      debugPrint("Error loading progres narasi: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadFAQ() async {
    try {
      _listFaq = await _repository.getAllFAQ();
      notifyListeners();
    } catch (e) {
      debugPrint("Error loading FAQ: $e");
    }
  }
  
  Future<void> loadParwa(String namaParwa) async {
    _isLoading = true;
    notifyListeners();
    try {
      _parwaAktif = await _repository.getParwa(namaParwa);
    } catch (e) {
      debugPrint("Error loading parwa: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  bool isBabakSelesai(int babakId) {
    return _progresUser.any((p) => p.babakId == babakId);
  }

  Future<void> tandaiSelesai(int userId, int babakId) async {
    await _repository.markBabakSelesai(userId, babakId);
    await loadProgres(userId); // reload state
  }
}
