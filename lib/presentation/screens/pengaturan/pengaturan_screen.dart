// import 'dart:convert';
// import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:share_plus/share_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../providers/auth_provider.dart';
import '../../../../providers/koleksi_provider.dart';
import '../../../../providers/narasi_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
// import '../../../../data/database/database_helper.dart';
import '../../widgets/profile_image.dart';
import 'kelola_profil_screen.dart';
import '../auth/login_screen.dart';

class PengaturanScreen extends StatefulWidget {
  const PengaturanScreen({super.key});

  @override
  State<PengaturanScreen> createState() => _PengaturanScreenState();
}

class _PengaturanScreenState extends State<PengaturanScreen> {
//   bool _isBackingUp = false;
//   bool _isRestoring = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final userId = authProvider.currentUser?.id;
      if (userId != null) {
        Provider.of<NarasiProvider>(context, listen: false).loadProgres(userId);
        Provider.of<KoleksiProvider>(context, listen: false).loadData(userId);
      }
    });
  }

//   Future<void> _eksporProgres() async {
//     // Cache context-dependent objects before async calls to prevent async gaps warnings
//     final scaffoldMessenger = ScaffoldMessenger.of(context);
// 
//     setState(() => _isBackingUp = true);
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     final userId = authProvider.currentUser?.id;
//     if (userId == null) {
//       setState(() => _isBackingUp = false);
//       return;
//     }
// 
//     try {
//       final dbHelper = DatabaseHelper.instance;
//       final backupData = await dbHelper.exportBackup(userId);
//       final jsonStr = const JsonEncoder.withIndent('  ').convert(backupData);
// 
//       final tempDir = await getTemporaryDirectory();
//       final tempFile = File('${tempDir.path}/bharatawayang_cadangan.json');
//       await tempFile.writeAsString(jsonStr);
// 
//       final xFile = XFile(tempFile.path);
//       await Share.shareXFiles([
//         xFile,
//       ], subject: 'Cadangan Progres BharataWayang');
// 
//       scaffoldMessenger.showSnackBar(
//         const SnackBar(
//           content: Text(
//             'Progres berhasil diekspor! Silakan simpan file cadangan.',
//           ),
//           backgroundColor: AppColors.primary,
//         ),
//       );
//     } catch (e) {
//       scaffoldMessenger.showSnackBar(
//         SnackBar(
//           content: Text('Gagal mengekspor progres: $e'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     } finally {
//       if (mounted) {
//         setState(() => _isBackingUp = false);
//       }
//     }
//   }
// 
//   Future<void> _imporProgres() async {
//     // Cache context-dependent objects before async calls to prevent async gaps warnings
//     final scaffoldMessenger = ScaffoldMessenger.of(context);
//     final koleksiProvider = Provider.of<KoleksiProvider>(
//       context,
//       listen: false,
//     );
//     final narasiProvider = Provider.of<NarasiProvider>(context, listen: false);
// 
//     setState(() => _isRestoring = true);
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     final userId = authProvider.currentUser?.id;
//     if (userId == null) {
//       setState(() => _isRestoring = false);
//       return;
//     }
// 
//     try {
//       final result = await FilePicker.platform.pickFiles(
//         type: FileType.custom,
//         allowedExtensions: ['json'],
//       );
// 
//       if (result == null || result.files.single.path == null) {
//         setState(() => _isRestoring = false);
//         return; // User cancelled
//       }
// 
//       final file = File(result.files.single.path!);
//       final jsonStr = await file.readAsString();
//       final backupData = jsonDecode(jsonStr);
// 
//       if (backupData is! Map<String, dynamic> ||
//           backupData['version'] == null) {
//         throw 'Format file cadangan tidak valid!';
//       }
// 
//       final dbHelper = DatabaseHelper.instance;
//       await dbHelper.importBackup(userId, backupData);
// 
//       // Reload data using cached providers
//       await koleksiProvider.loadData(userId);
//       await narasiProvider.loadProgres(userId);
// 
//       scaffoldMessenger.showSnackBar(
//         const SnackBar(
//           content: Text('Progres berhasil dipulihkan dari file cadangan! ✓'),
//           backgroundColor: AppColors.primary,
//         ),
//       );
//     } catch (e) {
//       scaffoldMessenger.showSnackBar(
//         SnackBar(
//           content: Text('Gagal mengimpor progres: $e'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     } finally {
//       if (mounted) {
//         setState(() => _isRestoring = false);
//       }
//     }
//   }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final narasiProvider = Provider.of<NarasiProvider>(context);
    final koleksiProvider = Provider.of<KoleksiProvider>(context);

    final user = authProvider.currentUser;
    final nama = user?.namaLengkap ?? user?.username ?? "RADEN ARJUNA";
    final bio = user?.bio ?? "Ksatria Pandawa • Penikmat Serat";

    final totalSeratDibaca = narasiProvider.progresUser
        .where((p) => p.sudahDibaca == 1)
        .length;
    final totalMustikaTerkumpul = koleksiProvider.koleksiUser.length;

    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'PROFIL PENGGUNA',
          style: AppTypography.headingSmall.copyWith(
            color: AppColors.textDark,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
            fontSize: 14,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: AppColors.accent.withValues(alpha: 0.3),
            height: 1.0,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Avatar Gunungan
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.accent, width: 3),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: ProfileImage(
                    fotoProfil: user?.fotoProfil,
                    size: 120,
                    fit: BoxFit.cover,
                    placeholder: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/images/ui/digital_gunungan_nobg.png',
                        fit: BoxFit.contain,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Nama & Bio
              Text(
                nama.toUpperCase(),
                style: AppTypography.headingLarge.copyWith(
                  color: AppColors.textDark,
                  letterSpacing: 2,
                  fontSize: 28,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                bio,
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textDark.withValues(alpha: 0.6),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // Tombol Kelola Profil
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(
                        MaterialPageRoute(
                          builder: (_) => const KelolaProfilScreen(),
                        ),
                      )
                      .then((_) {
                        if (!context.mounted) return;
                        // Refresh data after returning
                        final userId = authProvider.currentUser?.id;
                        if (userId != null) {
                          Provider.of<NarasiProvider>(
                            context,
                            listen: false,
                          ).loadProgres(userId);
                          Provider.of<KoleksiProvider>(
                            context,
                            listen: false,
                          ).loadData(userId);
                        }
                      });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  foregroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: AppColors.primary, width: 1),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'KELOLA PROFIL',
                  style: AppTypography.buttonText.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Pembatas SVG
              SvgPicture.asset(
                'assets/images/ui/divider.svg',
                width: 300,
                height: 12,
                fit: BoxFit.contain,
                colorFilter: const ColorFilter.mode(
                  AppColors.accent,
                  BlendMode.srcIn,
                ),
              ),

              const SizedBox(height: 40),

              // Serat Pribadi Section
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'SERAT PRIBADI',
                  style: AppTypography.headingSmall.copyWith(
                    color: AppColors.textDark,
                    letterSpacing: 2,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  // Kartu Kiri (Serat Dibaca)
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppColors.accent.withValues(alpha: 0.5),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.menu_book,
                            color: AppColors.accent,
                            size: 24,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                '$totalSeratDibaca',
                                style: AppTypography.headingLarge.copyWith(
                                  color: AppColors.primary,
                                  fontSize: 36,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'TOTAL',
                                style: AppTypography.labelText.copyWith(
                                  color: AppColors.primary,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'SERAT DIBACA',
                            style: AppTypography.labelText.copyWith(
                              color: AppColors.textDark.withValues(alpha: 0.6),
                              letterSpacing: 1.5,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Kartu Kanan (Mustika Terkumpul)
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppColors.accent.withValues(alpha: 0.5),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.diamond_outlined,
                            color: AppColors.accent,
                            size: 24,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            '$totalMustikaTerkumpul',
                            style: AppTypography.headingLarge.copyWith(
                              color: AppColors.primary,
                              fontSize: 36,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'MUSTIKA\nTERKUMPUL',
                            style: AppTypography.labelText.copyWith(
                              color: AppColors.textDark.withValues(alpha: 0.6),
                              letterSpacing: 1.5,
                              fontSize: 10,
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 48),

              // Tombol Keluar
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    context.read<AuthProvider>().logout();
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                      (route) => false,
                    );
                  },
                  icon: const Icon(Icons.exit_to_app, color: Colors.red),
                  label: Text(
                    'KELUAR',
                    style: AppTypography.buttonText.copyWith(
                      color: Colors.red,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: const BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 100), // Padding for floating bottom nav
            ],
          ),
        ),
      ),
    );
  }
}
