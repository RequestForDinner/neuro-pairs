import 'package:neuro_pairs/platform/image_picker_client.dart';
import 'package:neuro_pairs/platform/interfaces/i_image_picker_client.dart';
import 'package:neuro_pairs/presentation/app/di/injector.dart';

void injectPlatformClients() {
  Injector.instance.injectFactory<IImagePickerClient>(
    () => ImagePickerClient(),
  );
}
