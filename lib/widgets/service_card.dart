import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:music_services/model/music_service_model.dart';
import 'package:music_services/widgets/squircle_widget.dart';
import 'package:music_services/utils/utils.dart';

class ServiceCard extends StatelessWidget {
  final MusicService service;
  final VoidCallback onTap;

  const ServiceCard({super.key, required this.service, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SquircleWidget(
        borderRadius: 32,
        color: const Color(0xff2C2D31),
        borderSide: 1.0,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Image.asset('assets/images/${service.imagePath}').image,
              opacity: 0.1,
              fit: BoxFit.cover,
            ),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
            leading: SquircleWidget(
              color: Colors.transparent,
              borderRadius: 20,

              child: Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(color: Color(0xff2F2F39)),
                child:
                    service.iconPath.isNotEmpty
                        ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                            'assets/icons/${service.iconPath}',
                            height: 24,
                            width: 24,
                          ),
                        )
                        : const Icon(Icons.error, color: Colors.red),
              ),
            ),
            title: Text(
              service.title,
              style: Utils.syneBoldTextStyle.copyWith(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
            subtitle: Text(
              service.description,
              style: Utils.syneTextStyle.copyWith(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_right_sharp,
              color: Colors.white,
              size: 32,
            ),
          ),
        ),
      ),
    );
  }
}
