import 'package:feedback_loop/core/providers/theme_provider.dart';
import 'package:feedback_loop/core/theme/app_colors.dart';
import 'package:feedback_loop/presentation/providers/idea_provider.dart';
import 'package:feedback_loop/presentation/widgets/app_bar_custom.dart';
import 'package:feedback_loop/presentation/widgets/dashed_box_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class NewIdeaScreen extends ConsumerStatefulWidget {
  const NewIdeaScreen({super.key});

  @override
  ConsumerState<NewIdeaScreen> createState() => _NewIdeaScreenState();
}

class _NewIdeaScreenState extends ConsumerState<NewIdeaScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _selectedImageUrl;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _resetForm() {
    _titleController.clear();
    _descriptionController.clear();
    setState(() {
      _selectedImageUrl = null;
    });
  }

  void _pickMockImage() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        final sampleImages = [
          'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=600',
          'https://images.unsplash.com/photo-1522071820081-009f0129c71c?w=600',
          'https://images.unsplash.com/photo-1531403009284-440f080d1e12?w=600',
        ];

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Sélectionner une image d’illustration (Mock)',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              ListTile(
                leading: const Icon(Icons.add_photo_alternate, color: AppColors.primary),
                title: const Text('Illustration Projet Web & Mobile'),
                onTap: () {
                  setState(() => _selectedImageUrl = sampleImages[0]);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.group_work, color: AppColors.primary),
                title: const Text('Illustration Brainstorming & Équipe'),
                onTap: () {
                  setState(() => _selectedImageUrl = sampleImages[1]);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.design_services, color: AppColors.primary),
                title: const Text('Illustration Design & Prototypage'),
                onTap: () {
                  setState(() => _selectedImageUrl = sampleImages[2]);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _submitIdea() async {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez renseigner un titre pour votre idée.'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    if (description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez décrire votre idée.'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    final success = await ref.read(ideaListProvider.notifier).createIdea(
          title: title,
          description: description,
          imageUrl: _selectedImageUrl,
        );

    setState(() => _isSubmitting = false);

    if (mounted) {
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Votre idée a été publiée avec succès ! 🎉'),
            backgroundColor: AppColors.green,
          ),
        );
        _resetForm();
        context.go('/');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Une erreur est survenue lors de la publication.'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(isDarkProvider);
    final borderColor = isDark ? AppColors.darkBorder : Colors.black87;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      appBar: const AppBarCustom(
        title: 'Nouvelle idée',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),

              // Titre de l'idée field
              InputDecorator(
                decoration: InputDecoration(
                  labelText: "Titre de l'idée",
                  labelStyle: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.darkText : Colors.black87,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: borderColor, width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide:
                        const BorderSide(color: AppColors.primary, width: 2),
                  ),
                ),
                child: TextField(
                  controller: _titleController,
                  style: TextStyle(
                    fontSize: 15,
                    color: isDark ? AppColors.darkText : Colors.black87,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Parle nous de ton idée field
              InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Parle nous de ton idée',
                  labelStyle: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.darkText : Colors.black87,
                  ),
                  alignLabelWithHint: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: borderColor, width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide:
                        const BorderSide(color: AppColors.primary, width: 2),
                  ),
                ),
                child: SizedBox(
                  height: 140,
                  child: TextField(
                    controller: _descriptionController,
                    maxLines: null,
                    expands: true,
                    textAlignVertical: TextAlignVertical.top,
                    style: TextStyle(
                      fontSize: 15,
                      color: isDark ? AppColors.darkText : Colors.black87,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 4),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Dashed Box for Image Upload
              DashedBoxCustom(
                onTap: _pickMockImage,
                imagePreviewUrl: _selectedImageUrl,
                onClearImage: () {
                  setState(() => _selectedImageUrl = null);
                },
              ),

              const SizedBox(height: 28),

              // Actions Buttons Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Réinitialiser Button
                  OutlinedButton(
                    onPressed: _resetForm,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: AppColors.primary,
                        width: 1.5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 10,
                      ),
                      minimumSize: const Size(0, 42),
                    ),
                    child: const Text(
                      'Réinitialiser',
                      style: TextStyle(
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),

                  // Publier mon idée Button
                  ElevatedButton(
                    onPressed: _isSubmitting ? null : _submitIdea,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.green,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 10,
                      ),
                      minimumSize: const Size(0, 42),
                    ),
                    child: _isSubmitting
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            'Publier mon idée',
                            style: TextStyle(
                              fontSize: 15,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
