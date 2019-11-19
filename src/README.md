## Run Locally

Make sure you run the following commands from within the `src` directory by executing `cd src` first.

[Source](https://cloud.google.com/appengine/docs/flexible/python/quickstart)

1. If you don't have virtualenv, install it using pip.

```
sudo pip install virtualenv
```

2. Create an isolated Python environment, and install dependencies:

```
virtualenv --python python3 env
source env/bin/activate
pip install -r requirements.txt
```

3. Run the application:

```
python main.py
```

4. In your web browser, enter the following address: http://127.0.0.1:8080


5. Run the tests:

If you want to run all the tests, use [pytest](https://docs.pytest.org/en/latest/):

```
pytest
```


If you want to have the tests continue running (for example, while writing new tests), use [pytest-watch](https://pypi.org/project/pytest-watch/):

```
ptw
```

## Generating chapters

The chapter generation is dependent on nodejs, so you will need to have [nodejs](https://nodejs.org/en/) installed as well. All of the following commands must be run from within the `src` directory by executing `cd src` first.

1. Install the dependencies:

```
npm install
```

2. Run the generate chapters script:

```
npm run generate
```

## Deploying changes

If you've been added to the "App Engine Deployers" role in the GCP project, you're able to push code changes to the production website.

1. Install the [`gcloud`](https://cloud.google.com/sdk/install) Google Cloud SDK.

2. Authenticate the email address associated with the project with the `webalmanac` GCP project:

```
gcloud init
```

3. Stage the changes locally:

```
git checkout production
git status
git pull
git pull origin master
git push
```

  - Check out the `production` branch
  - Run `git status` to ensure you don't have any uncommitted changes locally
  - Merge any remote changes (both origin/production and origin/master branches)
  - Push the merge-commit back up to origin/production

4. Browse the website locally as one final QA test, then deploy the changes live:

```
npm run deploy
```

5. Browse the website in production to verify that the new changes have taken effect
