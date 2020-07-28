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

## Generating ebooks - including print-ready ebooks if you want a hardcopy

It is also possible to generate the ebook from the website (either production or 127.0.0.1), with some optional params (e.g. to print it!)

```
prince "http://127.0.0.1:8080/en/2019/ebook?print" -o web_almanac_2019_en.pdf --pdf-profile='PDF/UA-1'
```

Note `--pdf-profile='PDF/UA-1'` may not be needed if just intend to print.

Query params accepted are:

- print - this adds left, right pages, footnotes, and sets roman numerals for front matter page numbers and adds footnotes. It is used by default when running `npm run ebooks` but we could change that if prefer a less print-like ebook.
- printer - this adds crop marks, bleeds and trims. Also adds two additional pages at front which will need to be deleted in Acrobat or similar to get clean starting page.
- page-size - this allows you to override the default page size of A5.
- inside-margin - this allows you to set an inside margin for binding (e.g. on right for left hand pages and vice versa)
- bleed - add a bleed for printing (3mm by default)
- prince-trim - add a bleed for printing (5mm by default)
- base-font-size - set the base font-size (10px by default), which is useful if changing page size.
- max-fig-height - defaults to 610px (for A5) and prevents large images from causing overflows on to other pages with heading and caption.
- cover - this genarates a 4 page cover (front cover + spine + back cover, and same on inside which is blank). This ignores above options but has further params discussed below.

You can also download the HTML and override the inline styles there if you want to customise this for something we haven't exposed as a param.

So for a printer-ready A5 version, that you can send to a print to bind, you can do the following:

```
prince "http://127.0.0.1:8080/en/2019/ebook?print&printer" -o static/pdfs/web_almanac_2019_en_print_A5.pdf
```

This is the same as below since it uses all the default settings:

```
prince "http://127.0.0.1:8080/en/2019/ebook?print&printer&page-size=A5&inside-margin=19.5mm&bleed=3mm&prince-trim=5mm&base-font-size=10px" -o static/pdfs/web_almanac_2019_en_print_A5.pdf
```

Note this will create two extra pages at the begining which will need to be removed with a PDF editor (e.g. Adobe Acrobat) to start with a clean page starting on right hand side for printing. Please remove these before checking in versions into git.

It is also possible to generate a cover using the `&cover` URL param. This consists of basically 2 pages - the first page is a double width-page with front and back cover as one page (with spine in between) and the second page is a blank inside page.

```
prince "http://127.0.0.1:8080/en/2019/ebook?cover" -o static/pdfs/web_almanac_2019_en_cover_A5.pdf
```

Extra params accepted for the cover are are (note spine and pageWidth are unit-less to allow for easy addition in the code):

- spine - defaults to 25
- pageWidth - defaults to 148 (for A5). Note this is the front cover width and not the full width of front cover and back cover and spine.
- pageHeight - defaults to 210 (for A5)
- unit - which unit the above measurements are in (defaults to mm)
- base-font-size - set the base font-size (10px by default), which may need to be increased if changing page size.

So default is the same as:

```
prince "http://127.0.0.1:8080/en/2019/ebook?cover&spine=25&pageWidth=148&pageHeight=210&unit=mm&base-font-size=10px" -o static/pdfs/web_almanac_2019_en_cover_A5.pdf
```

Note, simialr to above, this will create one extra page at the begining which will need to be removed with a PDF editor to start with a clean page for printing. Please remove this before checking in versions into git.

With the print-ready eBook and Cover you can send them to a printer. I used https://www.digitalprintingireland.ie/ before and they were excellent and charge about €35 for a full-colour A5 ebook. Most of the settings above are for them, so tweak them based on your own printer's requirements.

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
