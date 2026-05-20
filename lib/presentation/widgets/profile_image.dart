import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class ProfileImage extends StatelessWidget {
  final String? fotoProfil;
  final double size;
  final BoxFit fit;
  final Widget? placeholder;

  const ProfileImage({
    super.key,
    required this.fotoProfil,
    this.size = 80,
    this.fit = BoxFit.cover,
    this.placeholder,
  });

  Future<String> _getLocalProfilePath(String fileName) async {
    final appDir = await getApplicationDocumentsDirectory();
    return '${appDir.path}/assets/photoprofile/$fileName';
  }

  @override
  Widget build(BuildContext context) {
    if (fotoProfil == null || fotoProfil!.isEmpty) {
      return placeholder ?? Image.asset(
        'assets/images/ui/digital_gunungan_nobg.png',
        fit: fit,
        width: size,
        height: size,
      );
    }

    if (fotoProfil!.startsWith('assets/')) {
      return Image.asset(
        fotoProfil!,
        fit: fit,
        width: size,
        height: size,
      );
    }

    return FutureBuilder<String>(
      future: _getLocalProfilePath(fotoProfil!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
          final file = File(snapshot.data!);
          if (file.existsSync()) {
            return Image.file(
              file,
              fit: fit,
              width: size,
              height: size,
            );
          }
        }
        return placeholder ?? Container(
          width: size,
          height: size,
          color: Colors.grey[300],
          child: const Icon(Icons.person, color: Colors.grey),
        );
      },
    );
  }
}
