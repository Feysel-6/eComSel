class EAuthException implements Exception {
  final String code;

  EAuthException(this.code);

  String get message {
    switch (code) {
      case 'invalid login credentials':
        return 'Incorrect email or password. Please try again.';
      case 'already registered':
      case 'user already registered':
        return 'This email is already registered. Try logging in.';
      case 'password should be at least 6 characters':
      case 'password must be at least 6 characters':
        return 'Password too weak. Please choose a stronger password.';
      case 'user not found':
        return 'No account found for that email. Please sign up.';
      case 'invalid email':
        return 'The email you entered is invalid. Please check and try again.';
      case 'account already exists with the same email':
        return 'An account already exists with that email. Try signing in.';
      case 'unverified':
      case 'email not confirmed':
        return 'Please verify your email before logging in.';
      case 'invalid otp':
      case 'invalid code':
        return 'The verification code is invalid. Please try again.';
      case 'expired action code':
      case 'code expired':
        return 'The verification code has expired. Please request a new one.';
      default:
      // If none of the above matches, fallback to generic message,
      // optionally include the raw message for debugging or logging.
        return 'Authentication failed: ${code.isNotEmpty ? code : 'Please try again.'}';
    }
  }

  @override
  String toString() => '[EAuthException] $code';
}
