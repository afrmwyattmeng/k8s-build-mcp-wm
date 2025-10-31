.PHONY: venv install update setup clean help

# Detect shell
SHELL_NAME := $(shell basename $$SHELL)

# Virtual environment directory
VENV_DIR := venv

# Determine activation script based on shell
ifeq ($(SHELL_NAME),fish)
    ACTIVATE := source $(VENV_DIR)/bin/activate.fish
else
    ACTIVATE := source $(VENV_DIR)/bin/activate
endif

help:
	@echo "Available targets:"
	@echo "  make setup   - Create venv and install dependencies (runs venv + install)"
	@echo "  make venv    - Create Python virtual environment"
	@echo "  make install - Install dependencies from requirements.txt"
	@echo "  make update  - Update dependencies (use when requirements.txt changes)"
	@echo "  make clean   - Remove virtual environment"
	@echo ""
	@echo "Detected shell: $(SHELL_NAME)"

venv:
	@echo "Creating virtual environment in $(VENV_DIR)..."
	python3 -m venv $(VENV_DIR)
	@echo "Virtual environment created!"
	@echo "To activate manually:"
ifeq ($(SHELL_NAME),fish)
	@echo "  source $(VENV_DIR)/bin/activate.fish"
else
	@echo "  source $(VENV_DIR)/bin/activate"
endif

_install_deps:
	@$(VENV_DIR)/bin/pip install --upgrade pip
	@$(VENV_DIR)/bin/pip install -r requirements.txt

install: venv _install_deps
	@echo "Dependencies installed!"

update: _install_deps
	@echo "Dependencies updated!"

setup: install
	@echo "Setup complete! Virtual environment is ready."
	@echo ""
	@echo "To activate the virtual environment, run:"
ifeq ($(SHELL_NAME),fish)
	@echo "  source $(VENV_DIR)/bin/activate.fish"
else
	@echo "  source $(VENV_DIR)/bin/activate"
endif

clean:
	@echo "Removing virtual environment..."
	rm -rf $(VENV_DIR)
	@echo "Virtual environment removed!"

