import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:canoptico_app/features/auth/auth.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginFormBloc(authBloc: context.read<AuthBloc>()),
        child: const _LoginScreenBody(),
      ),
    );
  }
}

class _LoginScreenBody extends StatelessWidget {
  const _LoginScreenBody();

  void showSnackBar(
    BuildContext context,
    String message, {
    bool isError = false,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.notAuthenticated &&
            state.errorMessage.isNotEmpty) {
          showSnackBar(context, state.errorMessage, isError: true);
        } else if (state.status == AuthStatus.authenticated) {
          showSnackBar(context, "Login successful!");
        }
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // -- app logo and title
                      const _AppLogo(),

                      const SizedBox(height: 32.0),

                      // -- login form card
                      Card(
                        elevation: 0.0,
                        margin: const EdgeInsets.all(0.0),
                        clipBehavior: Clip.hardEdge,
                        child: Column(
                          children: [
                            // -- header with welcome message
                            const _HeaderSection(),

                            // -- form fields and buttons
                            Container(
                              padding: const EdgeInsets.all(24.0),
                              child: Column(
                                children: [
                                  // -- username field
                                  const _FormSection(),

                                  const SizedBox(height: 16.0),
                                  Divider(
                                    thickness: 0.8,
                                    color: theme.dividerColor,
                                  ),
                                  const SizedBox(height: 16.0),

                                  const _FooterSection(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AppLogo extends StatelessWidget {
  const _AppLogo();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: theme.colorScheme.primary.withValues(alpha: 0.1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Icon(
              Icons.restaurant,
              color: theme.colorScheme.primary,
              size: 36,
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        Text("Canoptico App", style: theme.textTheme.headlineLarge),
        const SizedBox(height: 8.0),
        Text(
          "Smart Cat Feeding System",
          style: theme.textTheme.bodyMedium?.copyWith(fontSize: 16.0),
        ),
      ],
    );
  }
}

class _HeaderSection extends StatelessWidget {
  const _HeaderSection();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Theme.of(context).primaryColor.withValues(alpha: 0.05),
            Theme.of(context).primaryColor.withValues(alpha: 0.10),
          ],
        ),
      ),
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
      child: Column(
        children: [
          Text("Welcome Back!", style: theme.textTheme.headlineLarge),
          const SizedBox(height: 6.0),
          Text(
            "Sign in to access your feeder",
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class _FormSection extends StatelessWidget {
  const _FormSection();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<LoginFormBloc, LoginFormState>(
      builder: (context, state) {
        return Column(
          children: [
            FormFieldContainer(
              title: "Email",
              child: CustomTextFormField(
                label: "Enter your email",
                prefixIcon: Icon(
                  Icons.email_outlined,
                  size: 16,
                  color: theme.textTheme.bodyMedium?.color,
                ),
                keyboardType: TextInputType.emailAddress,
                errorMessage: state.shouldShowErrors
                    ? state.email.errorMessage
                    : null,
                onChanged: (value) => context.read<LoginFormBloc>().add(
                  LoginFormEmailChanged(value),
                ),
              ),
            ),

            // -- password field
            FormFieldContainer(
              title: "Password",
              child: CustomTextFormField(
                label: "Enter your password",
                prefixIcon: Icon(
                  Icons.lock_outline_rounded,
                  size: 16,
                  color: theme.textTheme.bodyMedium?.color,
                ),
                obscureText: true,
                errorMessage: state.shouldShowErrors
                    ? state.password.errorMessage
                    : null,
                onChanged: (value) => context.read<LoginFormBloc>().add(
                  LoginFormPasswordChanged(value),
                ),
              ),
            ),

            // -- sign in button
            SizedBox(
              width: double.infinity,
              child: BlocSelector<AuthBloc, AuthState, AuthStatus>(
                selector: (authState) {
                  return authState.status;
                },
                builder: (context, authStatus) {
                  final isAuthInProgress = authStatus == AuthStatus.checking;

                  return FilledButton(
                    onPressed: isAuthInProgress
                        ? null
                        : () {
                            FocusScope.of(context).unfocus();
                            context.read<LoginFormBloc>().add(
                              const LoginFormSubmitted(),
                            );
                          },
                    child: isAuthInProgress
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text("Sign In"),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _FooterSection extends StatelessWidget {
  const _FooterSection();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Text("Don't have an account?", style: theme.textTheme.bodyMedium),

        const SizedBox(height: 8.0),

        // -- create account button
        TextButton(
          onPressed: () => context.push("/signup"),
          child: const Text("Create Account"),
        ),
      ],
    );
  }
}
