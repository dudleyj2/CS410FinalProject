Getting started
===============

This project has been built using a cookiecutter template.

It assumes the use of a virtual environment in order to load
the required modules for the project without altering your
standard configuration.

Python 3 is assumed.  If you are not using Conda, then
virualenv is required.  It will be loaded automatically via
the make command to create the environment.

So... make is also required.

View the Documentation
----------------------

To view the documentation

.. code-block:: bash

    (reddit_recommender_bot) $ cd docs
    (reddit_recommender_bot) $ python -m http.server

Or, alternatively, just browse to file:///PROJECT_HOME/docs.

Access the Jupyter Notebooks
----------------------------

Use the virtual environment on the local machine
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code-block:: bash

    (reddit_recommender_bot) $ cd ${REPO}/docs
    (reddit_recommender_bot) $ ipython notebook

Use the virtual environment on an EWS machine
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code-block:: bash

    LOCAL_MACHINE$ ssh ${EWS_MACHINE} -L 8889:localhost:8889
    EWS_MACHINE$ cd ${REPO}
    EWS_MACHINE$ source venv/reddit_recommender_bot/bin/activate
    (reddit_recommender_bot) EWS_MACHINE$ ipython notebook --no-browser --port=8889

Using these notebooks with an existing server
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

There is something a bit strange about jupyter, ipython and virtual
environments.  In order to be able to *use* these notebooks with an existing
Jupyter server, it's important to set the "kernel" of the notebook to the 
virtual environment.  To do this, you have to set the virtual environment 
as one of the available kernels.

As shown, execute these commands *from* the virtual environment.  Furthermore,
ensure you've already executed either "make requirements" or "make data".

.. code-block:: bash

    (reddit_recommender_bot) $ python -m ipykernel install --user --name reddit_recommender_bot --display-name reddit_recommender_bot
    (reddit_recommender_bot) $ jupyter-notebook

Then from within Jupyter select the notebooks folder.

When done, remove the kernel with the following command: 

.. code-block:: bash

    (reddit_recommender_bot) $ jupyter kernelspec remove reddit_recommender_bot

Preparation
-----------

The Reddit Recommender Bot is a reddit bot.

In order to execute the recommender system, a bot is required.

Values in the src/config.py has to updated with below credentials:

.. code-block:: bash

    username    = 'SecureCondorBot'
    password    = 'YearlyCosmicMoth'
    client_id   = 'Zl5AadA6rXrZJQ'
    client_secret = 'LBxuCo8ofvoP4JLZi-WBn-BPON0'
    user_agent = 'Secure Condor Bot (a16b) v0'
    indexdir = 'data/processed'

If you already have a reddit account, a recommendation request can be done in 2 steps:
    1. Open a reddit post
    2. Type the summon request as a direct comment to the post or as a reply to an existing comment.

In order to request a recommendation, a Reddit login is required.

If you do not have a reddit account you can create a new one by;
go to https://www.reddit.com/ and click the Signup button.


Execution
---------

The execution of the recommender requires two ongoing processes.

The first process ingests the data and prepares it for analysis.

The second watches for requests and processes a query.

First, start the indexer:

.. code-block:: bash

    (reddit_recommender_bot) $ python src/indexer.py

Next, start the watcher:

.. code-block:: bash

    (reddit_recommender_bot) $ python src/watcher.py

It might ask you to install psaw, whoosh and pandas libraries manually (If makefile had failed to install them).
You can use below commands to do that;

.. code-block:: bash

    pip install psaw
    pip install whoosh
    pip install pandas

If dependent packages are still missing, use the following command to manually install the requirements:

.. code-block:: bash

    pip install -r requirements.txt

It's prudent to wait a few minutes for the indexer to ingest a sufficient number of comments.

Then, to initiate a query, access Reddit. 
These credentials can be used to test this bot instead of your own reddit account;

    username: CondorBotTest
    password: SecureCondorBotTest

Navigate to an interesting discussion, then post a reply including the bot name as shown:

	/u/SecureCondorBot

The watcher will capture the request and after a couple minutes, respond with a recommendation.



