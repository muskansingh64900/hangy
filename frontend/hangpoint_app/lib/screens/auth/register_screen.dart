import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'login_screen.dart';

// ─── Palette ────────────────────────────────────────────────────
const kBg = Color(0xFF111111);
const kCard = Color(0xFF1A1A1A);
const kBorder = Color(0xFF2A2A2A);
const kLime = Color(0xFFC8F135);
const kText = Color(0xFFF5F5F5);
const kMuted = Color(0xFF888888);
const kError = Color(0xFFFF4D6D);

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with TickerProviderStateMixin {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();

  bool _isLoading = false;
  bool _showPassword = false;
  bool _success = false;
  String? _errorMessage;

  late AnimationController _entryController;
  late AnimationController _logoController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;
  late Animation<double> _logoScaleAnim;
  late Animation<double> _logoFadeAnim;

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _entryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _logoScaleAnim = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOutBack),
    );
    _logoFadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOut),
    );
    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _entryController, curve: Curves.easeOut),
    );
    _slideAnim =
        Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero).animate(
      CurvedAnimation(parent: _entryController, curve: Curves.easeOutCubic),
    );

    _logoController.forward();
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) _entryController.forward();
    });
  }

  @override
  void dispose() {
    _entryController.dispose();
    _logoController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _cityController.text.isEmpty) {
      setState(() => _errorMessage = 'Please fill all required fields.');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      const baseUrl = 'http://localhost:5166';
      final response = await http.post(
        Uri.parse('$baseUrl/api/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': _nameController.text.trim(),
          'email': _emailController.text.trim(),
          'password': _passwordController.text,
          'phoneNumber': _phoneController.text.trim(),
          'city': _cityController.text.trim(),
          'state': _stateController.text.trim(),
          'country': 'India',
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() => _success = true);
        HapticFeedback.lightImpact();
        await Future.delayed(const Duration(milliseconds: 1200));
        if (mounted) _showSuccessSheet();
      } else {
        setState(() {
          _errorMessage = data['message'] ?? 'Registration failed.';
        });
      }
    } catch (e) {
      setState(() => _errorMessage = 'Cannot connect to server.');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showSuccessSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      builder: (_) => Container(
        padding: const EdgeInsets.fromLTRB(28, 32, 28, 48),
        decoration: const BoxDecoration(
          color: kCard,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: kBorder,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: kLime,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.check_rounded, color: kBg, size: 28),
            ),
            const SizedBox(height: 20),
            const Text(
              "you're in.",
              style: TextStyle(
                color: kText,
                fontSize: 32,
                fontWeight: FontWeight.w900,
                letterSpacing: -1.0,
                height: 1.0,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Account created successfully.\nTime to start hoppin.',
              style: TextStyle(color: kMuted, fontSize: 15, height: 1.6),
            ),
            const SizedBox(height: 32),
            _PrimaryButton(
              label: "LET'S GO",
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: SafeArea(
        child: Column(
          children: [
            // ── Top bar with logo ────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: kCard,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: kBorder),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: kText,
                        size: 15,
                      ),
                    ),
                  ),
                  const Spacer(),
                  ScaleTransition(
                    scale: _logoScaleAnim,
                    child: FadeTransition(
                      opacity: _logoFadeAnim,
                      child: const _HoppinLogo(),
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(width: 40),
                ],
              ),
            ),

            // ── Scrollable form ──────────────────────────────────
            Expanded(
              child: FadeTransition(
                opacity: _fadeAnim,
                child: SlideTransition(
                  position: _slideAnim,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 40),

                        const Text(
                          'Create\nAccount.',
                          style: TextStyle(
                            color: kText,
                            fontSize: 42,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -1.5,
                            height: 1.05,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'drop your location. find the vibe.',
                          style: TextStyle(
                            color: kMuted,
                            fontSize: 14,
                            letterSpacing: 0.1,
                          ),
                        ),

                        const SizedBox(height: 36),

                        if (_errorMessage != null) ...[
                          _ErrorBanner(message: _errorMessage!),
                          const SizedBox(height: 20),
                        ],

                        const _SectionLabel(label: 'WHO ARE YOU'),
                        const SizedBox(height: 14),

                        _Field(
                          controller: _nameController,
                          label: 'Full Name',
                          hint: 'your name',
                          icon: Icons.person_outline_rounded,
                        ),
                        const SizedBox(height: 10),
                        _Field(
                          controller: _phoneController,
                          label: 'Phone Number',
                          hint: '98765 43210',
                          icon: Icons.phone_outlined,
                          keyboardType: TextInputType.phone,
                        ),

                        const SizedBox(height: 28),
                        const _SectionLabel(label: 'LOGIN DETAILS'),
                        const SizedBox(height: 14),

                        _Field(
                          controller: _emailController,
                          label: 'Email',
                          hint: 'you@email.com',
                          icon: Icons.alternate_email_rounded,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 10),

                        _PasswordField(
                          controller: _passwordController,
                          show: _showPassword,
                          onToggle: () =>
                              setState(() => _showPassword = !_showPassword),
                        ),

                        const SizedBox(height: 28),
                        const _SectionLabel(label: 'WHERE YOU AT'),
                        const SizedBox(height: 14),

                        _Field(
                          controller: _cityController,
                          label: 'City',
                          hint: 'Delhi, Mumbai...',
                          icon: Icons.location_on_outlined,
                        ),
                        const SizedBox(height: 10),
                        _Field(
                          controller: _stateController,
                          label: 'State',
                          hint: 'Maharashtra',
                          icon: Icons.map_outlined,
                          isLast: true,
                        ),

                        const SizedBox(height: 36),

                        _isLoading
                            ? const _LoadingButton()
                            : _success
                                ? const _SuccessButton()
                                : _PrimaryButton(
                                    label: 'CREATE ACCOUNT',
                                    onTap: _register,
                                  ),

                        const SizedBox(height: 24),

                        Row(
                          children: [
                            Expanded(
                                child: Container(height: 1, color: kBorder)),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 14),
                              child: Text(
                                'already hoppin?',
                                style:
                                    TextStyle(color: kMuted, fontSize: 12),
                              ),
                            ),
                            Expanded(
                                child: Container(height: 1, color: kBorder)),
                          ],
                        ),

                        const SizedBox(height: 24),

                        GestureDetector(
                          onTap: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const LoginScreen()),
                          ),
                          child: Container(
                            height: 56,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: kBorder, width: 1.5),
                            ),
                            child: const Center(
                              child: Text(
                                'LOGIN',
                                style: TextStyle(
                                  color: kText,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 2.0,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 48),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── HOPPIN' Logo ────────────────────────────────────────────────
class _HoppinLogo extends StatelessWidget {
  const _HoppinLogo();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: const BoxDecoration(
            color: kLime,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 7),
        RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'HOPPIN',
                style: TextStyle(
                  color: kText,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 3.5,
                  height: 1,
                ),
              ),
              TextSpan(
                text: "'",
                style: TextStyle(
                  color: kLime,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0,
                  height: 1,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─── Section Label ───────────────────────────────────────────────
class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 3, height: 12, color: kLime),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            color: kMuted,
            fontSize: 10,
            fontWeight: FontWeight.w800,
            letterSpacing: 2.5,
          ),
        ),
      ],
    );
  }
}

// ─── Text Field ──────────────────────────────────────────────────
class _Field extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final TextInputType keyboardType;
  final bool isLast;

  const _Field({
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.keyboardType = TextInputType.text,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: kMuted,
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(height: 7),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          textInputAction:
              isLast ? TextInputAction.done : TextInputAction.next,
          style: const TextStyle(
            color: kText,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle:
                const TextStyle(color: Color(0xFF3A3A3A), fontSize: 14),
            prefixIcon: Icon(icon, color: kMuted, size: 18),
            filled: true,
            fillColor: kCard,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: kBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: kBorder, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: kLime, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Password Field ──────────────────────────────────────────────
class _PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final bool show;
  final VoidCallback onToggle;

  const _PasswordField({
    required this.controller,
    required this.show,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Password',
          style: TextStyle(
            color: kMuted,
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(height: 7),
        TextField(
          controller: controller,
          obscureText: !show,
          textInputAction: TextInputAction.next,
          style: const TextStyle(
            color: kText,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: 'min 6 characters',
            hintStyle:
                const TextStyle(color: Color(0xFF3A3A3A), fontSize: 14),
            prefixIcon: const Icon(Icons.lock_outline_rounded,
                color: kMuted, size: 18),
            suffixIcon: GestureDetector(
              onTap: onToggle,
              child: Icon(
                show
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: kMuted,
                size: 18,
              ),
            ),
            filled: true,
            fillColor: kCard,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: kBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: kBorder, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: kLime, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Primary Button ──────────────────────────────────────────────
class _PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _PrimaryButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: kLime,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: kBg,
              fontSize: 14,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Loading Button ──────────────────────────────────────────────
class _LoadingButton extends StatelessWidget {
  const _LoadingButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: kLime,
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Center(
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(color: kBg, strokeWidth: 2.5),
        ),
      ),
    );
  }
}

// ─── Success Button ──────────────────────────────────────────────
class _SuccessButton extends StatelessWidget {
  const _SuccessButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: kLime,
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.check_rounded, color: kBg, size: 20),
          SizedBox(width: 8),
          Text(
            'ACCOUNT CREATED',
            style: TextStyle(
              color: kBg,
              fontSize: 14,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Error Banner ────────────────────────────────────────────────
class _ErrorBanner extends StatelessWidget {
  final String message;
  const _ErrorBanner({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      decoration: BoxDecoration(
        color: kError.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: kError.withOpacity(0.25)),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline_rounded, color: kError, size: 16),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: kError, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}