/// Core module barrel file
/// Re-exports all core utilities, constants, theme, and widgets
library core;

// Constants
export 'constants/app_constants.dart';
export 'constants/database_constants.dart';

// Configuration
export 'env/app_config.dart';

// Theme
export 'theme/app_colors.dart';
export 'theme/app_text_styles.dart';
export 'theme/app_theme.dart';

// Utils
export 'utils/extensions.dart';
export 'utils/validators.dart';

// Interfaces
export 'interfaces/local_storage_interface.dart';
export 'interfaces/remote_storage_interface.dart';

// Widgets
export 'widgets/widgets.dart';
