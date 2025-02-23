# Variables
BUILD_DIR = /home/theaux/Citadel/build/$(shell date '+%Y-%m-%d')
ISO_NAME = citadel-linux.iso
SOURCE_DIR = /home/theaux/Citadel/iso-profiles/releng
WORK_DIR = /tmp/archiso-tmp

# Cible par défaut : build l'ISO
.PHONY: all
all: build

# Cible pour la construction de l'ISO
.PHONY: build
build:
	@echo "[+] Génération de l'ISO dans $(BUILD_DIR)..."
	@mkdir -p "$(BUILD_DIR)"
	@sudo mkarchiso -v -w "$(WORK_DIR)" -o "$(BUILD_DIR)" "$(SOURCE_DIR)"

# Cible pour nettoyer les fichiers générés (dossier de build)
.PHONY: clean
clean:
	@echo "[+] Nettoyage du répertoire de build..."
	@rm -rf "$(BUILD_DIR)"
	@sudo rm -rf "$(WORK_DIR)"

# Cible pour reconstruire l'ISO (clean + build)
.PHONY: re
re: clean build
