import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:najia/utils/constant.dart';

HisnulMuslimCard(context, title, arabic, english, reference) {
  return GestureDetector(
    onTap: () => {},
    child: Padding(
      padding: const EdgeInsets.only(
        left: 10.0,
        right: 10.0,
      ),
      child: Card(
        elevation: 0,
        margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      height: 2, fontSize: 13, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        arabic,
                        textDirection: TextDirection.rtl,
                        style: const TextStyle(
                            height: 2, fontFamily: 'amiri', fontSize: 22),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  english,
                  style: const TextStyle(height: 2, fontSize: 12),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: GestureDetector(
                      onTap: () async => {
                        await Clipboard.setData(ClipboardData(
                            text: title +
                                "\n\n" +
                                arabic +
                                "\n\n" +
                                english +
                                "\n\n"
                                    "Hisnul Muslim - Shared with Najia App ")),
                        _showToast(context, "Hisnul Muslim")
                      },
                      child: const Icon(
                        Icons.copy,
                        color: Colors.amber,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

void _showToast(BuildContext context, data) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
        content: Text(
          data + ' has been copied to clipboard!',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: NajiaColors.black),
  );
}