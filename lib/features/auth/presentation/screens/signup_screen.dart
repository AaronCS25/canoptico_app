import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:canoptico_app/config/config.dart';
import 'package:canoptico_app/features/auth/auth.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => SignupFormBloc(
          signupCallback: ServiceLocator.get<AuthRepository>().register,
        ),
        child: const _SignupScreenBody(),
      ),
    );
  }
}

class _SignupScreenBody extends StatelessWidget {
  const _SignupScreenBody();

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

    return BlocListener<SignupFormBloc, SignupFormState>(
      listenWhen: (previous, current) =>
          previous.submissionStatus != current.submissionStatus,
      listener: (context, state) {
        if (state.isSubmissionSuccess) {
          showSnackBar(context, "Account created successfully!");
          context.canPop() ? context.pop() : context.go("/login");
        } else if (state.isSubmissionFailure) {
          showSnackBar(
            context,
            state.errorMessage ?? "Signup failed.",
            isError: true,
          );
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
                                  // -- form
                                  const _FormSection(),

                                  const SizedBox(height: 16.0),
                                  Divider(
                                    thickness: 0.8,
                                    color: theme.dividerColor,
                                  ),
                                  const SizedBox(height: 16.0),

                                  // -- footer
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
          Text("Create Account", style: theme.textTheme.headlineLarge),
          const SizedBox(height: 6.0),
          Text(
            "Join canoptico to get started",
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

    return BlocBuilder<SignupFormBloc, SignupFormState>(
      builder: (context, state) {
        return Column(
          children: [
            // -- username field
            FormFieldContainer(
              title: "Username",
              child: CustomTextFormField(
                label: "Enter your username",
                prefixIcon: Icon(
                  Icons.person_outline_outlined,
                  color: theme.textTheme.bodyMedium?.color,
                ),
                keyboardType: TextInputType.name,
                errorMessage: state.shouldShowErrors
                    ? state.userName.errorMessage
                    : null,
                onChanged: (value) => context.read<SignupFormBloc>().add(
                  SignupFormNameChanged(value),
                ),
              ),
            ),
            // -- email field
            FormFieldContainer(
              title: "Email",
              child: CustomTextFormField(
                label: "Enter your email",
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: theme.textTheme.bodyMedium?.color,
                ),
                keyboardType: TextInputType.emailAddress,
                errorMessage: state.shouldShowErrors
                    ? state.email.errorMessage
                    : null,
                onChanged: (value) => context.read<SignupFormBloc>().add(
                  SignupFormEmailChanged(value),
                ),
              ),
            ),

            // -- password field
            FormFieldContainer(
              title: "Password",
              subtitle: "Must be at least 8 characters long",
              child: CustomTextFormField(
                label: "Enter your password",
                prefixIcon: Icon(
                  Icons.lock_outline_rounded,
                  color: theme.textTheme.bodyMedium?.color,
                ),
                obscureText: true,
                errorMessage: state.shouldShowErrors
                    ? state.password.errorMessage
                    : null,
                onChanged: (value) => context.read<SignupFormBloc>().add(
                  SignupFormPasswordChanged(value),
                ),
              ),
            ),

            // -- sign in button
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: state.isSubmitting
                    ? null
                    : () {
                        FocusScope.of(context).unfocus();
                        context.read<SignupFormBloc>().add(
                          const SignupFormSubmitted(),
                        );
                      },
                child: state.isSubmitting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text("Create Account"),
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
        Text("Already have an account?", style: theme.textTheme.bodyMedium),

        const SizedBox(height: 8.0),

        // -- create account button
        TextButton(
          onPressed: () =>
              context.canPop() ? context.pop() : context.go("/login"),
          child: const Text("Sign In"),
        ),
      ],
    );
  }
}
