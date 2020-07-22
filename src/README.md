# Developing the Web Almanac

The Web Almanac can be developed on macOS, Windows or Linux. It requires Node v12 and Python v3 to be installed. Alternatively, use Docker to avoid manually configuring the development environment.

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

3. For generating PDFs of the ebook, you need to install Prince. Follow the instructions on [the Prince Website](https://www.princexml.com/).

4. To actually generate the ebooks, start your local server, then run the following:

```
npm run ebooks
```

It is also possible to generate the ebook from the website, with some optional params (e.g. to print it!)

```
prince "https://almanac.httparchive.org/en/2019/ebook?print&inside-margin=4cm" -o web_almanac_2019_en.pdf --pdf-profile='PDF/UA-1'
```

Note `--pdf-profile='PDF/UA-1'` may not be needed if just intend to print.

Params accepted are:

- print - this ads left, right pages, footnotes, and sets roman numerals for front matter page numbers and adds footnotes. It is used by default when running `npm run ebooks` but we could change that if prefer a less print-like ebook.
- page-size - this allows you to override the default page size of A4
- inside-margin - this allows you to set an inside margin for binding (e.g. on right for left hand pages and vice versa)

You can also download the HTML and override the inline styles there if you want to customise this for something we haven;t exposed as a param.

## Deploying changes

If you've been added to the "App Engine Deployers" role in the GCP project, you're able to push code changes to the production website.

_Make sure you have generated the ebooks PDFs as that currently requires some extra steps that are not automated!_

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
git pull origin main
git push
```

  - Check out the `production` branch
  - Run `git status` to ensure you don't have any uncommitted changes locally
  - Merge any remote changes (both origin/production and origin/main branches)
  - Push the merge-commit back up to origin/production

4. Browse the website locally as one final QA test, then deploy the changes live:

```
npm run deploy
```

5. Browse the website in production to verify that the new changes have taken effect

## Developing in Docker

Assuming that you have Docker installed and running, ensure that the working directory is `src`, where the `Dockerfile` is present, before running the following commands.

1. Build a Docker image named `webalmanac` (if you choose a different name, adjust following commands accordingly):

```
docker image build -t webalmanac .
```

2. Run the application server (which is the default command of the Docker image, so no need to explicitly supply it as an argument):

```
docker container run --rm -it -v "$PWD":/app -p 8080:8080 webalmanac
```

3. Open http://localhost:8080 in your web browser to access the site. You can kill the server when it is no longer needed using `Ctrl+C`.

4. Make changes in the code using any text editor and run tests (need to build the image again if any Python or Node dependencies are changed):

```
docker container run --rm -it -v "$PWD":/app webalmanac pytest
```

5. To avoid running commands in one-off mode run `bash` in a container (with necessary volumes mounted and ports mapped) then run successive commands:

```
docker container run --rm -it -v "$PWD":/app -v /app/node_modules -p 8080:8080 webalmanac bash
root@[CID]:/app# pytest
root@[CID]:/app# python main.py
^C
root@[CID]:/app# npm run generate
root@[CID]:/app# exit
```

6. To customize the image use `PYVER`, `NODEVER`, and `SKIPGC` build arguments to control which versions of Python and Node are used and whether Google Cloud SDK is installed.

```
docker image build --build-arg PYVER=3.7 --build-arg NODEVER=14.x --build-arg SKIPGC=false -t webalmanac:custom .
```
