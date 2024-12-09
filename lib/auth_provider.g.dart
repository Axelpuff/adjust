// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$isAuthenticatedHash() => r'8db53a40b5be1156daebe359e773fb0beb436d3c';

/// See also [IsAuthenticated].
@ProviderFor(IsAuthenticated)
final isAuthenticatedProvider =
    AutoDisposeNotifierProvider<IsAuthenticated, bool>.internal(
  IsAuthenticated.new,
  name: r'isAuthenticatedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isAuthenticatedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$IsAuthenticated = AutoDisposeNotifier<bool>;
String _$fociHash() => r'bfa976d97c68b3cda7990d9284371adf8b5eb297';

/// See also [Foci].
@ProviderFor(Foci)
final fociProvider = AutoDisposeAsyncNotifierProvider<Foci,
    Map<String, Map<String, String>>>.internal(
  Foci.new,
  name: r'fociProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$fociHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Foci = AutoDisposeAsyncNotifier<Map<String, Map<String, String>>>;
String _$currentFocusHash() => r'0df22bccbb147cc61e9d15e4b380eae0dfb6651a';

/// See also [CurrentFocus].
@ProviderFor(CurrentFocus)
final currentFocusProvider =
    AutoDisposeAsyncNotifierProvider<CurrentFocus, String?>.internal(
  CurrentFocus.new,
  name: r'currentFocusProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$currentFocusHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentFocus = AutoDisposeAsyncNotifier<String?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
