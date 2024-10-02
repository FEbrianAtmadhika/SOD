import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sod_new/bloc/Auth/auth_bloc.dart';
import 'package:sod_new/models/authmodel.dart';
import '../shared/theme.dart';
import '../widgets/button.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: backgroundgreenColor,
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: greenColor,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          "Alamat Saya",
          style: blackTextStyle.copyWith(
            fontSize: 18,
            fontWeight: semiBold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
          if (state is AuthSuccess) {
            AuthModel? data = state.data;

            if (data.address != null && data.address!.isNotEmpty) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ...data.address!.map((e) {
                      return Column(
                        children: [
                          Card(
                            color: whiteColor,
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        e.receiverName ?? 'Unknown Receiver',
                                        style: blackTextStyle.copyWith(
                                          fontSize: 18,
                                          fontWeight: semiBold,
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: (e.type == 'home'
                                              ? blueColor.withOpacity(0.2)
                                              : redColor.withOpacity(0.2)),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(50)),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 3, horizontal: 5),
                                        child: Text(
                                          '${e.type?[0].toUpperCase() ?? ''}${e.type?.substring(1) ?? ''}',
                                          style: (e.type == 'home'
                                              ? blueTextStyle.copyWith(
                                                  fontSize: 10,
                                                  fontWeight: regular)
                                              : redTextStyle.copyWith(
                                                  fontSize: 10,
                                                  fontWeight: regular)),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      const Icon(Icons.phone),
                                      Text(
                                        e.receiverPhone ?? 'No phone number',
                                        style: greyTextStyle.copyWith(
                                          fontSize: 16,
                                          fontWeight: regular,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: <Widget>[
                                      const Icon(Icons.location_on),
                                      Expanded(
                                        child: Text(
                                          "${e.address ?? 'Unknown address'}, ${e.subDistrict?.name ?? ''}, ${e.subDistrict?.districtInfo?.name ?? ''}",
                                          style: greyTextStyle.copyWith(
                                            fontSize: 16,
                                            fontWeight: regular,
                                          ),
                                          maxLines: 3,
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        decoration: BoxDecoration(
                                          color: (e.status == 'active'
                                              ? greenColor.withOpacity(0.2)
                                              : redColor.withOpacity(0.2)),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(50)),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 3, horizontal: 5),
                                        child: Text(
                                          '${e.status?[0].toUpperCase() ?? ''}${e.status?.substring(1) ?? ''}',
                                          style: (e.status == 'active'
                                              ? greenTextStyle.copyWith(
                                                  fontSize: 10,
                                                  fontWeight: regular)
                                              : redTextStyle.copyWith(
                                                  fontSize: 10,
                                                  fontWeight: regular)),
                                        ),
                                      ),
                                      ElevatedButtonFilledIconSmall(
                                        text: 'Edit',
                                        onPressed: () {
                                          Navigator.of(context).pushNamed(
                                              '/editaddress',
                                              arguments: e.id);
                                        },
                                        icon: const Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      );
                    }),
                    ElevatedButtonFilled(
                      text: "+   Tambah Alamat Baru",
                      onPressed: () {
                        Navigator.pushNamed(context, '/addAddress');
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              );
            } else {
              return const Center(
                child: Text('No addresses available'),
              );
            }
          } else if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const Center(
              child: Text('Failed to load addresses'),
            );
          }
        }),
      ),
    );
  }
}
