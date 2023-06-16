// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../router/route_constante.dart';
import '../service/auth.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isloading = false;

  logout() {
    SnackBar snackBar;

    Provider.of<Auth>(context, listen: false).logout().then((value) => {
          setState(() {
            isloading = false;
          }),
          if (value == false)
            {
              snackBar = const SnackBar(
                content: Text('error Connection'),
              ),
              ScaffoldMessenger.of(context).showSnackBar(snackBar),
            }
          else
            {
              snackBar = const SnackBar(
                content: Text('Déconnecter'),
              ),
              ScaffoldMessenger.of(context).showSnackBar(snackBar),
              context.pop(RouteConst.home),
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      backgroundColor: const Color(0xfff6f6f6),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: ListView(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Consumer<Auth>(builder: (context, auth, child) {
                if (auth.authenticed) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 70.0,
                          backgroundImage: NetworkImage(auth.user?.image ??
                              'https://lessor.ml/assets/img/user.png'),
                        ),
                        Expanded(
                          child: Text(
                              '${auth.user?.firstname} ${auth.user?.lastname} ',
                              style:
                                  TextStyle(fontSize: 30, color: Colors.black)),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Row();
                }
              }),
              Consumer<Auth>(builder: (context, auth, child) {
                if (auth.authenticed) {
                  return Row();
                } else {
                  return _SingleSection(
                    title: "Compte",
                    children: [
                      _CustomListTile(
                        title: "Se conecter",
                        icon: CupertinoIcons.person_alt_circle_fill,
                        onTap: () {
                          context.pushNamed(RouteConst.login);
                        },
                      ),
                      // _CustomListTile(
                      //     title: "Dark Mode",
                      //     icon: CupertinoIcons.moon,
                      //     trailing:
                      //         CupertinoSwitch(value: false, onChanged: (value) {}))

                      _CustomListTile(
                          title: "Créer un compte",
                          icon: CupertinoIcons.person_add_solid),
                      // _CustomListTile(
                      //     title: "Security Status",
                      //     icon: CupertinoIcons.lock_shield),
                    ],
                  );
                }
              }),
              _SingleSection(
                title: "ÉDITION ABONNÉs",
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  _CustomListTile(
                    title: "S'abonner",
                    icon: Icons.sd_card_outlined,
                    onTap: () {
                      context.pushNamed(RouteConst.abonnement);
                    },
                  ),
                  // _CustomListTile(
                  //   title: "Wi-Fi",
                  //   icon: CupertinoIcons.wifi,
                  //   trailing: CupertinoSwitch(value: true, onChanged: (val) {}),
                  // ),
                  // _CustomListTile(
                  //   title: "Bluetooth",
                  //   icon: CupertinoIcons.bluetooth,
                  //   trailing:
                  //       CupertinoSwitch(value: false, onChanged: (val) {}),
                  // ),
                  // const _CustomListTile(
                  //   title: "VPN",
                  //   icon: CupertinoIcons.desktopcomputer,
                  // )
                ],
              ),
              const _SingleSection(
                title: "RÉGLAGE DE L'APPLICATION",
                children: [
                  _CustomListTile(
                      title: "Notifications", icon: CupertinoIcons.bell_fill),
                  // _CustomListTile(
                  //     title: "Apparance", icon: CupertinoIcons.lock),
                  _CustomListTile(
                      title: "Apparance", icon: CupertinoIcons.brightness),
                  // _CustomListTile(
                  //     title: "Sound and Vibration",
                  //     icon: CupertinoIcons.speaker_2),
                  // _CustomListTile(
                  //     title: "Themes", icon: CupertinoIcons.paintbrush)
                ],
              ),
              const _SingleSection(
                title: "AIDE ET SUPPORT",
                children: [
                  _CustomListTile(title: "FAG", icon: CupertinoIcons.person_2),
                  // _CustomListTile(
                  //     title: "Apparance", icon: CupertinoIcons.lock),
                  _CustomListTile(
                      title: "Nous contacter", icon: CupertinoIcons.phone_down),
                  // _CustomListTile(
                  //     title: "Sound and Vibration",
                  //     icon: CupertinoIcons.speaker_2),
                  // _CustomListTile(
                  //     title: "Themes", icon: CupertinoIcons.paintbrush)
                ],
              ),
              Consumer<Auth>(builder: (context, auth, child) {
                if (auth.authenticed) {
                  return _SingleSection(
                    title: "Deconnection",
                    children: [
                      isloading
                          ? Row(
                              children: [
                                Text('Patientez'),
                                const CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ],
                            )
                          : _CustomListTile(
                              title: "Déconnecter",
                              icon: CupertinoIcons.person_2,
                              onTap: () {
                                setState(() {
                                  isloading = true;
                                });
                                logout();
                              },
                            ),
                      // _CustomListTile(
                      //     title: "Apparance", icon: CupertinoIcons.lock),
                      // _CustomListTile(
                      //     title: "Sound and Vibration",
                      //     icon: CupertinoIcons.speaker_2),
                      // _CustomListTile(
                      //     title: "Themes", icon: CupertinoIcons.paintbrush)
                    ],
                  );
                } else {
                  return Row();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? trailing;
  final GestureTapCallback? onTap;
  const _CustomListTile(
      {Key? key,
      required this.title,
      required this.icon,
      this.trailing,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      trailing: trailing ?? const Icon(CupertinoIcons.forward, size: 18),
      onTap: onTap,
    );
  }
}

class _SingleSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _SingleSection({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title.toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .displaySmall
                ?.copyWith(fontSize: 16),
          ),
        ),
        Container(
          width: double.infinity,
          color: Colors.white,
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}
