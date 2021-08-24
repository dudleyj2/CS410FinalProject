.PHONY: clean data lint requirements

#################################################################################
# GLOBALS                                                                       #
#################################################################################

PROJECT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
BUCKET = [OPTIONAL] your-bucket-for-syncing-data (do not include 's3://')
PROFILE = default
PROJECT_NAME = reddit_recommender_bot
PYTHON_INTERPRETER = python3

ifeq (,$(shell which conda 2>/dev/null))
HAS_CONDA=False
else
HAS_CONDA=True
endif

#################################################################################
# COMMANDS                                                                      #
#################################################################################

## Install Python Dependencies
requirements: test_environment
ifeq (True,$(HAS_CONDA))
ifeq ($(PROJECT_NAME),$(CONDA_DEFAULT_ENV))
	$(PYTHON_INTERPRETER) -m pip install -U pip setuptools wheel
	$(PYTHON_INTERPRETER) -m pip install -r requirements.txt
else
	@echo ">>> First enter the virtualenv with:"
	@echo ">>>     source activate $(PROJECT_NAME)"
	@echo ">>> (or create it with make create_environment"
endif
else
ifeq ($(PROJECT_NAME),$(notdir $(VIRTUAL_ENV)))
	$(PYTHON_INTERPRETER) -m pip install -U pip setuptools wheel
	$(PYTHON_INTERPRETER) -m pip install -r requirements.txt
else
	@echo ">>> First enter the virtualenv with:"
	@echo ">>>     source venv/$(PROJECT_NAME)/bin/activate"
	@echo ">>> (or create it with make create_environment"
endif
endif

## Update Documentation
documentation:
ifeq (True,$(HAS_CONDA))
ifeq ($(PROJECT_NAME),$(CONDA_DEFAULT_ENV))
	cd doc_source && make clean && make html
else
	@echo ">>> First enter the virtualenv with:"
	@echo ">>>     source activate $(PROJECT_NAME)"
	@echo ">>> (or create it with make create_environment"
endif
else
ifeq ($(PROJECT_NAME),$(notdir $(VIRTUAL_ENV)))
	cd doc_source && make clean && make html
else
	@echo ">>> First enter the virtualenv with:"
	@echo ">>>     source venv/$(PROJECT_NAME)/bin/activate"
	@echo ">>> (or create it with make create_environment"
endif
endif

### Make Dataset
#data: requirements
#	$(PYTHON_INTERPRETER) src/data/make_dataset.py data models

## Delete all compiled Python files
clean:
	find . -type f -name "*.py[co]" -delete
	find . -type d -name "__pycache__" -delete

## Delete processed data
clean_data:
	rm -rf data/processed/*

## Lint using flake8
lint:
	flake8 src

## Set up python interpreter environment
create_environment:
ifeq (True,$(HAS_CONDA))
		@echo ">>> Detected conda, creating conda environment."
ifeq (3,$(findstring 3,$(PYTHON_INTERPRETER)))
	conda create --name $(PROJECT_NAME) python=3
else
	conda create --name $(PROJECT_NAME) python=2.7
endif
		@echo ">>> New conda env created. Activate with:"
		@echo ">>>     source activate $(PROJECT_NAME)"
else
	rm -rf venv/$(PROJECT_NAME)
	mkdir -p venv/$(PROJECT_NAME)
	$(PYTHON_INTERPRETER) -m venv venv/$(PROJECT_NAME)
	@echo ">>> New virtualenv created. Activate with:"
	@echo ">>>     source venv/$(PROJECT_NAME)/bin/activate"
endif

## Remove the  python interpreter environment
destroy_environment:
ifeq (True,$(HAS_CONDA))
ifeq ($(PROJECT_NAME),$(CONDA_DEFAULT_ENV))
	@echo ">>> Please exit the environment first using \"conda deactivate\""
else
	rm -rf $${CONDA_EXE%/bin/conda}/envs/$(PROJECT_NAME)
endif
else
ifeq ($(PROJECT_NAME),$(notdir $(VIRTUAL_ENV)))
	@echo ">>> Please exit the environment first using \"deactivate\""
else
	rm -rf venv/$(PROJECT_NAME)
endif
endif

## Test python environment is setup correctly
test_environment:
	$(PYTHON_INTERPRETER) test_environment.py

#################################################################################
# PROJECT RULES                                                                 #
#################################################################################



#################################################################################
# Self Documenting Commands                                                     #
#################################################################################

.DEFAULT_GOAL := help

# Inspired by <http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html>
# sed script explained:
# /^##/:
# 	* save line in hold space
# 	* purge line
# 	* Loop:
# 		* append newline + line to hold space
# 		* go to next line
# 		* if line starts with doc comment, strip comment character off and loop
# 	* remove target prerequisites
# 	* append hold space (+ newline) to line
# 	* replace newline plus comments by `---`
# 	* print line
# Separate expressions are necessary because labels cannot be delimited by
# semicolon; see <http://stackoverflow.com/a/11799865/1968>
.PHONY: help
help:
	@echo "$$(tput bold)Available rules:$$(tput sgr0)"
	@echo
	@sed -n -e "/^## / { \
		h; \
		s/.*//; \
		:doc" \
		-e "H; \
		n; \
		s/^## //; \
		t doc" \
		-e "s/:.*//; \
		G; \
		s/\\n## /---/; \
		s/\\n/ /g; \
		p; \
	}" ${MAKEFILE_LIST} \
	| LC_ALL='C' sort --ignore-case \
	| awk -F '---' \
		-v ncol=$$(tput cols) \
		-v indent=19 \
		-v col_on="$$(tput setaf 6)" \
		-v col_off="$$(tput sgr0)" \
	'{ \
		printf "%s%*s%s ", col_on, -indent, $$1, col_off; \
		n = split($$2, words, " "); \
		line_length = ncol - indent; \
		for (i = 1; i <= n; i++) { \
			line_length -= length(words[i]) + 1; \
			if (line_length <= 0) { \
				line_length = ncol - indent - length(words[i]) - 1; \
				printf "\n%*s ", -indent, " "; \
			} \
			printf "%s ", words[i]; \
		} \
		printf "\n"; \
	}' \
	| more $(shell test $(shell uname) = Darwin && echo '--no-init --raw-control-chars')
