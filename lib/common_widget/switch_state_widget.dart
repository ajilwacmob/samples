import 'package:flutter/material.dart';
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
        return SizedBox(
          width: size.width,
          height: isRequiredSystemHeight ? size.height : size.height * .5,
          child: const Center(
              child: Text(
            "Has no data",
            style: TextStyle(color: Colors.black),
          )),
        );
      case LoaderState.error:
        return SizedBox(
          width: size.width,
          height: isRequiredSystemHeight ? size.height : size.height * .5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                errorMessage ?? "",
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: isRequiredSystemHeight ? 100 : 30,
              ),
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
