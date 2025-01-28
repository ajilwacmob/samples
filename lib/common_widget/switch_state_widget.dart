import 'package:flutter/material.dart';
import 'package:samples/chat_module/utils/extension.dart';
import 'package:samples/painter/loader_painter.dart';
import 'package:samples/utils/loader_states.dart';

class SwitchStateWidget extends StatelessWidget {
  final LoaderState loaderState;
  final String? errorMessage;
  final Widget child;
  final Function() loadAgain;
  final bool isRequiredSystemHeight;
  const SwitchStateWidget({
    super.key,
    required this.loaderState,
    required this.child,
    this.errorMessage,
    required this.loadAgain,
    required this.isRequiredSystemHeight,
  });

  Widget get noInternetWidget => ErrorWidget(
        title: "No Internet",
        description: "Please check your internet connection",
        loadAgain: loadAgain,
        icon: Icons.wifi_off,
      );

  Widget get serverErrorWidget => ErrorWidget(
        title: "Server Error",
        description: "Please try again later",
        loadAgain: loadAgain,
        icon: Icons.computer_rounded,
      );

  Widget get commonErrorWidget => ErrorWidget(
        title: "Error",
        description: "Something went wrong!",
        loadAgain: loadAgain,
        icon: Icons.error_outline,
      );

  Widget get noDatatWidget => const ErrorWidget(
        title: "No Data",
        description: "Nothing to show",
        icon: Icons.data_array_outlined,
      );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    switch (loaderState) {
      case LoaderState.initial:
        return Loader(isRequiredSystemHeight: isRequiredSystemHeight);
      case LoaderState.loading:
        return Loader(isRequiredSystemHeight: isRequiredSystemHeight);
      case LoaderState.loaded:
        return const SizedBox(
          height: 0,
        );
      case LoaderState.hasData:
        return SizedBox(
          width: isRequiredSystemHeight ? size.width : null,
          height: isRequiredSystemHeight ? size.height : null,
          child: child,
        );
      case LoaderState.noData:
        return noDatatWidget;
      case LoaderState.error:
        return commonErrorWidget;
      case LoaderState.networkError:
        return noInternetWidget;
      case LoaderState.serverError:
        return serverErrorWidget;
    }
  }
}

class ErrorWidget extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final String? description;
  final Function()? loadAgain;
  const ErrorWidget({
    super.key,
    this.title,
    this.icon,
    this.description,
    this.loadAgain,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon ?? Icons.error, size: 100, color: Colors.black),
          10.verticalSpace,
          Text(
            title ?? "Error",
            style: const TextStyle(
                fontSize: 22, color: Colors.black, fontWeight: FontWeight.w500),
          ),
          5.verticalSpace,
          Text(
            description ?? "Somenthing went wrong!",
            style: const TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500),
          ),
          if (loadAgain != null) 30.verticalSpace,
          if (loadAgain != null)
            SizedBox(
              width: 120,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(), elevation: 1),
                onPressed: loadAgain,
                child: const Text("Reload"),
              ),
            ),
        ],
      ),
    );
  }
}

class Loader extends StatelessWidget {
  final bool isRequiredSystemHeight;
  const Loader({super.key, required this.isRequiredSystemHeight});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: isRequiredSystemHeight ? size.height : size.height * .5,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomLoader(
            size: Size(45, 45),
          )
        ],
      ),
    );
  }
}
