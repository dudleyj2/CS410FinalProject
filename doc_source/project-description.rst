Project Description
===================

This section will serve to document how things work:
    * Assumptions
    * General Data Flow
    * General architecture of files and directories
    * General architecture of scripts

Assumptions
-----------

    * Current version of recommender request does not work when the request is made by the same person who created the post. 
    * The Bot will not work if the post has been deleted/archived concurrently right after you entered the request.

Data Flow
---------

**Indexer**

An inverted index is used to build the logic to scoring and recommending sub reddits.
Whoosh, psaw and pushshift.io have been used to build up the logic.
 
Whoosh is a pure Python search engine library which contains more sophisticated helper functions for a ranking system.Â  It defaults to Okapi BM 25.Â  
It supports gradual, continual, updates, etc.Â  Furthermore, it allows to store things with the inverted index as well as index multiple "fields" of a document.

Using psaw and pushshift.io created another benefit or option.Â  Rather than starting with nothing and building the inverted index as new comments roll on in, psaw.pushshift.io created the option to specify a start time in the recent past.Â  The indexer will then start pulling in all the comments from that moment in time.

**Watcher**

The main process of Watcher is eatch/track mentions in realtime. Basically, we used reddit inbox as the storage for recommondation requests and we query the user mentions received to the inbox.is reading the user mentions of the reddit box.

**Responder**

Responder processes the request and responds with the proper sub reddit recommendation. It first use the inverted index and okapai BM25 to score the document and and then select the top 10% of the ranked subreddits. The ranking logic is applied to this selected set of subreddits.
Main steps of Responder logic:

    * Use the inverted index and Okapi BM25 to score the documents
    * Select the top 10%
    * Group by submission
    * Take the harmonic mean within each submission
    * Multiply by the log of the count of matched documents per submission

Directory Structure
-------------------

For the most part, this project follows the data-science cookiecutter template.

data

Datasets of various formats.

models

Models, outputs, summaries, etc.

src

The programs or scripts

src/data

Scripts to generate or transform data.

src/data/data.ini

A config file that specifies the datasets from the Chicago Data Portal.

src/features

Scripts to do feature engineering, etc.

src/models

Scripts to do modeling.

tests

Scripts for pytest.

Program/Script Structure
------------------------

Each python script in this project may be accessed by others
via import or called directly from the command line.









