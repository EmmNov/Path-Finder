import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:path_finder/domain/repository/url_repository.dart';

part 'url_state.dart';

class UrlCubit extends Cubit<UrlState> {
  UrlCubit(this._urlRepository) : super(const UrlState());

  final UrlRepository _urlRepository;

  Future<void> getUrl() async {
    final url = await _urlRepository.getUrl();
    emit(state.copyWith(url: url, urlStateStatus: UrlStateStatus.valid));
  }

  Future<void> saveUrl() async {
    if (state.urlStateStatus == UrlStateStatus.invalid) return;
    await _urlRepository.saveUrl(state.url);
  }

  changedUrl(String url) {
    Uri? uri = Uri.tryParse(url);
    if (uri != null &&
        (uri.scheme == 'http' || uri.scheme == 'https') &&
        uri.host.isNotEmpty) {
      emit(state.copyWith(urlStateStatus: UrlStateStatus.valid, url: url));
      return;
    }

    emit(state.copyWith(
        message: 'Invalid Url', urlStateStatus: UrlStateStatus.invalid));
  }
}
