# Makefile for deploying the Flutter web projects to GitHub
# From https://codewithandrea.com/articles/flutter-web-github-pages/

BASE_HREF = /$(NAME)/
# Replace with your GitHub username
GITHUB_USER = Axelpuff
GITHUB_REPO = https://$(PAT)@github.com/$(GITHUB_USER)/$(NAME)
BUILD_VERSION := $(if $(NAME),$(shell grep 'version:' $(NAME)/pubspec.yaml | awk '{print $$2}'))

# Deploy the Flutter web project to GitHub
deploy:
ifndef NAME
	$(error NAME is not set. Usage: make deploy NAME=<name> PAT=<pat>)
endif
ifndef PAT
	$(error PAT is not set. Usage: make deploy NAME=<name> PAT=<pat>)
endif

	@echo "Clean existing repository"
	flutter clean

	@echo "Getting packages..."
	flutter pub get

	@echo "Generating code..."
	dart run build_runner build

	@echo "Generating the web folder..."
	flutter create . --platform web

	@echo "Building for web..."
	flutter build web --base-href $(BASE_HREF) --release

	@echo "Deploying to git repository"
	cd build/web && \
	git init && \
	git add . && \
	git commit -m "Deploy Version $(BUILD_VERSION)" && \
	git branch -M main && \
	git remote add origin $(GITHUB_REPO) && \
	git config http.postBuffer 524288000
	git push -u -f origin main

	@echo "✅ Finished deploy: $(GITHUB_REPO)"
	@echo "🚀 Flutter web URL: https://$(GITHUB_USER).github.io/$(NAME)/"

## Archive the project as a zip file
zip:
ifndef NAME
	$(error NAME is not set. Usage: make zip NAME=<name>)
endif
	@echo "Clean existing repository"
	flutter clean && rm -rf .idea android ios linux macos windows web test *.iml || true

	@echo "Creating zipped project"
	rm $(NAME).zip || true && zip -r $(NAME).zip $(NAME)

## Create new Flutter project and copy all the files from the template
create:
ifndef NAME
	$(error NAME is not set. Usage: make create NAME=<name>)
endif

	@echo "Creating new Flutter project..."
	flutter create -e $(NAME)

	@echo "Copying files from the template..."
	cp -r template/.vscode $(NAME)
	cp template/.gitignore $(NAME)
	cp template/CHANGELOG.md $(NAME)
	cp template/LICENSE.md $(NAME)
	cp template/README.md $(NAME)

	@echo "Getting packages..."
	cd $(NAME) && flutter pub get

	@echo "✅ Finished creating new project: $(NAME)"

## Prepare for development
dev:
ifndef NAME
	$(error NAME is not set. Usage: make dev NAME=<name>)
endif
	@echo "Getting packages..."
	cd $(NAME) && flutter pub get

	@echo "Generating the platform folders..."
	cd $(NAME) && flutter create .

	@echo "Deleting the test folder..."
	cd $(NAME) && rm -rf test || true

.PHONY: deploy
