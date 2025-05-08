# Default feature name (can be overridden when running the command)
FEATURE_NAME ?= feature_name

# Target to create the folder structure
create_structure:
	@echo "Creating folder structure for feature: $(FEATURE_NAME)"
	@mkdir -p lib/features/$(FEATURE_NAME)/data/dataSources
	@mkdir -p lib/features/$(FEATURE_NAME)/data/dataSources/local
	@mkdir -p lib/features/$(FEATURE_NAME)/data/dataSources/remote
	@mkdir -p lib/features/$(FEATURE_NAME)/data/models
	@mkdir -p lib/features/$(FEATURE_NAME)/data/repositories
	@mkdir -p lib/features/$(FEATURE_NAME)/domain/entities
	@mkdir -p lib/features/$(FEATURE_NAME)/domain/repositories
	@mkdir -p lib/features/$(FEATURE_NAME)/domain/usecases
	@mkdir -p lib/features/$(FEATURE_NAME)/presentation/blocs
	@mkdir -p lib/features/$(FEATURE_NAME)/presentation/components
	@mkdir -p lib/features/$(FEATURE_NAME)/presentation/helpers
	@mkdir -p lib/features/$(FEATURE_NAME)/presentation/screens
	@echo "Folder structure created successfully for feature: $(FEATURE_NAME)"

# Clean target to remove the folder structure
clean_structure:
	@echo "Removing folder structure for feature: $(FEATURE_NAME)"
	@rm -rf lib/features/$(FEATURE_NAME)
	@echo "Folder structure removed successfully for feature: $(FEATURE_NAME)"

generate_firebase:
	@echo "Generating Firebase configuration release and debug"
	./flutterfire_config.sh release
	./flutterfire_config.sh debug
	@echo "Firebase configuration generated successfully"