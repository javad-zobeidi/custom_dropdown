import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: MyWidget(),
        ),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  final GlobalKey _buttonKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    OverlayEntry? overlayEntry;
    bool menuOpen = false;
    return Column(mainAxisSize: MainAxisSize.min, children: [
      const SizedBox(child: Text("Widget 1")),
      const SizedBox(height: 3),
      InkWell(
          key: _buttonKey,
          onTap: () {
            final RenderBox buttonBox =
                _buttonKey.currentContext!.findRenderObject() as RenderBox;
            final buttonPosition = buttonBox.localToGlobal(Offset.zero);

            final overlayPosition = Offset(
              buttonPosition.dx,
              buttonPosition.dy + buttonBox.size.height + 3,
            );

            if (menuOpen) {
              overlayEntry?.remove();
              overlayEntry = null;
              menuOpen = false;
            } else {
              overlayEntry = OverlayEntry(
                builder: (context) => Positioned(
                  top: overlayPosition.dy,
                  left: overlayPosition.dx,
                  child: MenuWidget(menuClosed: () {
                    overlayEntry?.remove();
                    overlayEntry = null;
                    menuOpen = false;
                  }),
                ),
              );
              menuOpen = true;
              Overlay.of(context).insert(overlayEntry!);
            }
          },
          child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                border: Border.all(color: Colors.black38),
              ),
              child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("Style"), Icon(Icons.arrow_drop_down)]))),
      const SizedBox(height: 3),
      const SizedBox(child: Text("Widget 2")),
      const SizedBox(height: 3),
      const SizedBox(child: Text("Widget 3")),
      const SizedBox(height: 3),
      const SizedBox(child: Text("Widget 4")),
    ]);
  }
}

class MenuWidget extends StatelessWidget {
  final void Function() menuClosed;
  const MenuWidget({required this.menuClosed});
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
            padding: const EdgeInsets.all(8),
            height: MediaQuery.sizeOf(context).height / 2,
            width: MediaQuery.sizeOf(context).width / 1.035,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              border: Border.all(color: Colors.black38),
            ),
            child: Column(children: [
              SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: Text("style".toUpperCase(),
                      style: TextStyle(color: Colors.grey[500]))),
              const SizedBox(height: 5),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Expanded(
                    child: ItemsWidget(
                  onTap: () {
                    menuClosed.call();
                  },
                  backgroundColor: Colors.green,
                  borderColor: Colors.green,
                  iconColor: Colors.white,
                  textColor: Colors.white,
                )),
                const SizedBox(width: 4),
                Expanded(
                    child: ItemsWidget(
                  onTap: () {
                    menuClosed.call();
                  },
                  backgroundColor: Colors.white,
                  borderColor: Colors.black38,
                  iconColor: Colors.green,
                  textColor: Colors.black,
                )),
              ]),
              const SizedBox(height: 4),
              Row(children: [
                Expanded(
                    child: ItemsWidget(
                  onTap: () {
                    menuClosed.call();
                  },
                  backgroundColor: Colors.greenAccent,
                  borderColor: Colors.green,
                  iconColor: Colors.black,
                  textColor: Colors.black,
                )),
                const SizedBox(width: 4),
                Expanded(
                    child: ItemsWidget(
                  onTap: () {
                    menuClosed.call();
                  },
                  backgroundColor: Colors.white,
                  borderColor: Colors.black38,
                  iconColor: Colors.green,
                  textColor: Colors.black,
                )),
              ])
            ])));
  }
}

class ItemsWidget extends StatelessWidget {
  const ItemsWidget({
    this.onTap,
    required this.backgroundColor,
    required this.borderColor,
    required this.iconColor,
    required this.textColor,
  });
  final Color backgroundColor;
  final Color borderColor;
  final Color iconColor;
  final Color textColor;
  final GestureTapCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20),
            height: MediaQuery.sizeOf(context).height / 5.5,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(7),
              border: Border.all(color: Colors.black38),
            ),
            child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(7),
                    topRight: Radius.circular(0),
                    bottomLeft: Radius.circular(7),
                    bottomRight: Radius.circular(0),
                  ),
                  border: Border(
                    right: BorderSide(color: borderColor, width: 0),
                    top: BorderSide(color: borderColor),
                    left: BorderSide(color: borderColor),
                    bottom: BorderSide(color: borderColor),
                  ),
                ),
                child: Row(children: [
                  Icon(Icons.check_circle_outline, color: iconColor),
                  const SizedBox(width: 8),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("The Title", style: TextStyle(color: textColor)),
                        const SizedBox(height: 4),
                        Text("The Description",
                            style: TextStyle(color: textColor)),
                      ])
                ]))));
  }
}
