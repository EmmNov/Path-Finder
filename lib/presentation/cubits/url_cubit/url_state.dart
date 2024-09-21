part of 'url_cubit.dart';

enum UrlStateStatus { initial, valid, invalid }

extension UrlStateStatusX on UrlStateStatus {
  bool get isInitial => this == UrlStateStatus.initial;
  bool get isValid => this == UrlStateStatus.valid;
  bool get isInvalid => this == UrlStateStatus.invalid;
}

class UrlState extends Equatable {
  const UrlState(
      {this.urlStateStatus = UrlStateStatus.initial,
      this.url = '',
      this.message = ''});
  final UrlStateStatus urlStateStatus;
  final String url;
  final String message;

  UrlState copyWith({
    UrlStateStatus? urlStateStatus,
    String? url,
    String? message,
  }) {
    return UrlState(
      urlStateStatus: urlStateStatus ?? this.urlStateStatus,
      url: url ?? this.url,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [urlStateStatus, url, message];
}
