Commands
========

The Makefile contains the central entry points for common tasks related to this project.

Create Environment
------------------

`make create_environment` will create the virtual environment for the project.

If you have Conda installed, it will attempt to use that.

Otherwise, it will use virtualenv.

The name of the virtual environment is set to the PROJECT_NAME as defined in
the Makefile.  Change there if necessary.

After you have executed this command, do the following to enter, exit and remove
the virtual environment.

If Conda:

* Enter the virtual environment:

.. code-block:: bash

    $ conda activate reddit_recommender_bot

* Exit the virtual environment:

.. code-block:: bash

    (reddit_recommender_bot)$ conda deactivate

* Delete the virtual environment:

.. code-block:: bash

    $ rm -rf ${CONDA_HOME}/envs/reddit_recommender_bot

If virtualenv:

* Enter the virtual environment:

.. code-block:: bash

    $ source `which virtualenvwrapper.sh`
    $ export WORKON_HOME=$HOME/.virtualenvs
    $ workon reddit_recommender_bot

* Exit the virtual environment:

.. code-block:: bash

    (reddit_recommender_bot)$ deactivate

* Delete the virtual environment:

.. code-block:: bash

    $ rm -rf ${WORKON_HOME}/reddit_recommender_bot


Install Requirements
--------------------

`make requirements` will add to the virtual environment 
the necessary modules for the project.

**NOTE: Be certain to be in the virtual environment for this step!**

Do this in order to be able to create documentation via Sphinx
or to be able to view and work with the Jupyter notebooks.


Create or Update Documentation
------------------------------

Documentation is written in RST and transformed to HTML.

To create or to update the documentation:

.. code-block:: bash

    (reddit_recommender_bot) $ cd doc_source
    (reddit_recommender_bot) $ make html


