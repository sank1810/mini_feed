import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mini_feed/supabase/auth_service.dart';
import 'package:mini_feed/ui/view_models/profile_view_model.dart';

class ProfileScreen extends StatefulWidget {
  final ProfileViewModel _viewModel;
  const ProfileScreen({super.key, required ProfileViewModel viewModel})
    : _viewModel = viewModel;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AnimatedBuilder(
          animation: widget._viewModel,
          builder: (context, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FutureBuilder(
                  future: _authService.getUserName(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return LinearProgressIndicator();
                    } else {
                      return Text(
                        snapshot.data!,
                        style: GoogleFonts.lobster(fontSize: 30),
                      );
                    }
                  },
                ),
                SizedBox(height: 12),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 100,
                      backgroundImage: widget._viewModel.profileImageUrl != null
                          ? NetworkImage(
                              "${widget._viewModel.profileImageUrl!}?v=${DateTime.now().millisecondsSinceEpoch}",
                            )
                          : AssetImage('assets/images/profile_icon.png')
                                as ImageProvider,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8, right: 8),
                      child: IconButton(
                        onPressed: () {
                          showBottomSheet(context);
                        },
                        icon: Icon(Icons.edit),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.grey[400],
                          foregroundColor: Colors.deepPurple,
                        ),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(32),
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Posts \n 200", textAlign: TextAlign.center),
                        VerticalDivider(),
                        Text("Followers \n 200", textAlign: TextAlign.center),
                        VerticalDivider(),
                        Text("suivis \n 200", textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      useRootNavigator: true,
      context: context,
      builder: (context) {
        return SizedBox(
          height: 200,
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(height: 10),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: Icon(Icons.highlight_remove),
                    iconSize: 30,
                  ),

                  Spacer(),
                  Text(
                    "Photo de profil",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.delete_forever_rounded),
                    iconSize: 30,
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      widget._viewModel.editAvatar(ImageSource.camera);
                      context.pop();
                    },
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.all(14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.camera_alt_outlined, size: 28),
                        Text("Camera"),
                      ],
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      widget._viewModel.editAvatar(ImageSource.gallery);
                      context.pop();
                    },
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.all(14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Column(
                      children: [Icon(Icons.image, size: 28), Text("Gallerie")],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
