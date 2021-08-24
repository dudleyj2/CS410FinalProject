reddit_discussion_recommender
==============================

A Reddit bot to locate and recommend similar ongoing discussions.

Did you come here first?  Well and good.  That's to be expected.

But don't stay here.  You want to hop on over to the real project
documentation.

To do that, either browse to file:///PROJECT_HOME/docs or start a simple
http server as follows:

```bash
$ cd PROJECT_HOME/docs
$ python -m http.server
```

Then browse to http://0.0.0.0:8000

The above works well enough but does assume you've cloned the repo to your
local machine.

The following will work if you've cloned the repo on an EWS machine but would
like to browse the documentation from your local machine...

```bash
LOCAL_MACHINE$ ssh ${EWS_MACHINE} -L 8000:localhost:8000
EWS_MACHINE$ cd ${REPO_LOCATION}/docs
EWS_MACHINE$ python3 -m http.server
```

Now you can go to http://localhost:8000/ on the local machine.



General file structure (based on the data-science cookiecutter template) follows...

Project Organization
------------

    ├── LICENSE
    ├── Makefile           <- Makefile with commands like `make data` or `make train`
    ├── README.md          <- The top-level README for developers using this project.
    ├── data
    │   ├── external       <- Data from third party sources.
    │   ├── interim        <- Intermediate data that has been transformed.
    │   ├── processed      <- The final, canonical data sets for modeling.
    │   └── raw            <- The original, immutable data dump.
    │
    ├── docs               <- A default Sphinx project; see sphinx-doc.org for details
    │
    ├── models             <- Trained and serialized models, model predictions, or model summaries
    │
    ├── notebooks          <- Jupyter notebooks.
    │
    ├── references         <- Data dictionaries, manuals, and all other explanatory materials.
    │
    ├── reports            <- Generated analysis as HTML, PDF, LaTeX, etc.
    │   └── figures        <- Generated graphics and figures to be used in reporting
    │
    ├── requirements.txt   <- The requirements file for reproducing the analysis environment, e.g.
    │                         generated with `pip freeze > requirements.txt`
    │
    ├── setup.py           <- makes project pip installable (pip install -e .) so src can be imported
    ├── src                <- Source code for use in this project.
    │   ├── __init__.py    <- Makes src a Python module
    │   │
    │   ├── data           <- Scripts to download or generate data
    │   │   └── make_dataset.py
    │   │
    │   ├── features       <- Scripts to turn raw data into features for modeling
    │   │   └── build_features.py
    │   │
    │   ├── models         <- Scripts to train models and then use trained models to make
    │   │   │                 predictions
    │   │   ├── predict_model.py
    │   │   └── train_model.py
    │   │
    │   └── visualization  <- Scripts to create exploratory and results oriented visualizations
    │       └── visualize.py
    │
    └── tox.ini            <- tox file with settings for running tox; see tox.testrun.org


--------

<p><small>Project based on the <a target="_blank" href="https://drivendata.github.io/cookiecutter-data-science/">cookiecutter data science project template</a>. #cookiecutterdatascience</small></p>
