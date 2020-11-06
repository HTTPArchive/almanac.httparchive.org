# Developing the Web Almanacr
r
The Web Almanac can be developed on macOS, Windows or Linux. It requires Node v12, Python v3.8 and pip to be installed. Alternatively, use Docker to avoid manually configuring the development environment.r
r
## Run Locallyr
r
Make sure you run the following commands from within the `src` directory by executing `cd src` first.r
r
[Source](https://cloud.google.com/appengine/docs/flexible/python/quickstart)r
r
Make sure Python (3.8 or above) and NodeJS (v12) are installed on your machine.r
r
1. If you don't have virtualenv, install it using pip.r
r
```r
sudo pip install virtualenvr
```r
r
Or for Windowsr
r
```r
py -m pip install --user virtualenvr
```r
r
2. Create an isolated Python environment, and install dependencies:r
r
```r
virtualenv --python python3 envr
source env/bin/activater
```r
r
Or for those on Windows:r
r
```r
virtualenv --python python3 envr
env\Scripts\activate.batr
```r
r
r
3. Install generate and run the website:r
r
```r
npm run startr
```r
r
Or on Windows:r
r
```r
npm run winstartr
```r
r
4. In your web browser, enter the following address: http://127.0.0.1:8080r
r
r
## Generating chaptersr
r
The chapter generation is dependent on nodejs, so you will need to have [nodejs](https://nodejs.org/en/) installed as well. All of the following commands must be run from within the `src` directory by executing `cd src` first.r
r
Note this is run automatically by the `npm run start command above` but is listed here separately in case you want to regenerate if making changes to chapters.r
r
Install the dependencies:r
r
```r
npm installr
```r
r
Run the generate chapters script:r
r
```r
npm run generater
```r
r
If you have the server up you can test all the pages are being served correctly:r
r
```r
npm run testr
```r
r
## Generating Ebooksr
r
For generating PDFs of the ebook, you need to install Prince. Follow the instructions on [the Prince Website](https://www.princexml.com/) and pdftk.r
r
To actually generate the ebooks, start your local server, then run the following:r
r
```r
npm run ebooksr
```r
r
There is a GitHub Action which can be run manually from the Actions tab to generate the Ebooks and open a Pull Request for them. This is the easiest way to generate them.r
r
## Generating ebooks - including print-ready ebooks if you want a hardcopyr
r
It is also possible to generate the ebook from the website (either production or 127.0.0.1), with some optional params (e.g. to print it with different settings).r
r
```r
prince "http://127.0.0.1:8080/en/2019/ebook?print" -o web_almanac_2019_en.pdf --pdf-profile='PDF/UA-1'r
```r
r
Note `--pdf-profile='PDF/UA-1'` may not be needed if just intend to print.r
r
Query params accepted are:r
r
- print - this adds left, right pages, footnotes, and sets roman numerals for front matter page numbers and adds footnotes. It is used by default when running `npm run ebooks` but we could change that if prefer a less print-like ebook.r
- printer - this adds crop marks, bleeds and trims. Also adds two additional pages at front which will need to be deleted in Acrobat or similar to get clean starting page.r
- page-size - this allows you to override the default page size of A5.r
- inside-margin - this allows you to set an inside margin for binding (e.g. on right for left hand pages and vice versa)r
- bleed - add a bleed for printing (3mm by default)r
- prince-trim - add a bleed for printing (5mm by default)r
- base-font-size - set the base font-size (10px by default), which is useful if changing page size.r
- max-fig-height - defaults to 610px (for A5) and prevents large images from causing overflows on to other pages with heading and caption.r
- cover - this genarates a 4 page cover (front cover + spine + back cover, and same on inside which is blank). This ignores above options but has further params discussed below.r
r
You can also download the HTML and override the inline styles there if you want to customise this for something we haven't exposed as a param, and then run prince against the file.r
r
So for a printer-ready A5 version, that you can send to a print to bind, you can do the following:r
r
```r
prince "http://127.0.0.1:8080/en/2019/ebook?print&printer" -o static/pdfs/web_almanac_2019_en_print_A5.pdfr
```r
r
This is the same as below since it uses all the default settings:r
r
```r
prince "http://127.0.0.1:8080/en/2019/ebook?print&printer&page-size=A5&inside-margin=19.5mm&bleed=3mm&prince-trim=5mm&base-font-size=10px" -o static/pdfs/web_almanac_2019_en_print_A5.pdfr
```r
r
Note this will create two extra pages at the begining which will need to be removed with a PDF editor (e.g. Adobe Acrobat) to start with a clean page starting on right hand side for printing. Please remove these before checking in versions into git.r
r
It is also possible to generate a cover using the `&cover` URL param. This consists of basically 2 pages - the first page is a double width-page with front and back cover as one page (with spine in between) and the second page is a blank inside page.r
r
```r
prince "http://127.0.0.1:8080/en/2019/ebook?cover" -o static/pdfs/web_almanac_2019_en_cover_A5.pdfr
```r
r
Extra params accepted for the cover are are (note spine and pageWidth are unit-less to allow for easy addition in the code):r
r
- spine - the width of the spine (defaults to 25)r
- pageWidth - the front cover width (note is just the page width and not the full width of front cover and back cover and spine) - defaults to 148 (for A5).r
- pageHeight - defaults to 210 (for A5)r
- unit - which unit the above measurements are in (defaults to mm)r
- base-font-size - set the base font-size (10px by default), which may need to be increased if changing page size.r
r
So default is the same as:r
r
```r
prince "http://127.0.0.1:8080/en/2019/ebook?cover&spine=25&pageWidth=148&pageHeight=210&unit=mm&base-font-size=10px" -o static/pdfs/web_almanac_2019_en_cover_A5.pdfr
```r
r
Note, similar to above, this will create one extra page at the begining which will need to be removed with a PDF editor to start with a clean page for printing. Please remove this before checking in versions into git.r
r
With the print-ready eBook and Cover you can send them to a printer. I used https://www.digitalprintingireland.ie/ before and they were excellent and charge about €35 for a full-colour A5 ebook. Most of the settings above are for them, so tweak them based on your own printer's requirements.r
r
## Deploying changesr
r
If you've been added to the "App Engine Deployers" role in the GCP project, you're able to push code changes to the production website.r
r
_Make sure you have generated the ebooks PDFs first in the main branch, by running the Generate Ebooks GitHub Action_r
r
1. Install the [`gcloud`](https://cloud.google.com/sdk/install) Google Cloud SDK.r
r
2. Authenticate the email address associated with the project with the `webalmanac` GCP project:r
r
```r
gcloud initr
```r
r
3. Deploy the site:r
r
```r
npm run deployr
```r
r
The deploy script will do the following:r
- Ask you to confirm you've updated the eBooks via GitHub Actionsr
- Switch to the production branchr
- Merge changes from mainr
- Do a clean installr
- Run the testsr
- Ask you to complete any local tests and confirm good to deployr
- Ask for a version number (suggesing the last verision tagged and incrementing the patch)r
- Tag the release (after asking you for the version number to use)r
- Generate a `deploy.zip` file of what has been deployedr
- Deploy to GCPr
- Push changes to `production` branch on GitHubr
- Ask you to update the release section of GitHubr
r
4. Browse the website in production to verify that the new changes have taken effect. Not we have 3 hour caching so add random query params to pages to ensure you get latest version.r
r
## Developing in Dockerr
r
Assuming that you have Docker installed and running, ensure that the working directory is `src`, where the `Dockerfile` is present, before running the following commands.r
r
1. Build a Docker image named `webalmanac` (if you choose a different name, adjust following commands accordingly):r
r
```r
docker image build -t webalmanac .r
```r
r
2. Run the application server (which is the default command of the Docker image, so no need to explicitly supply it as an argument):r
r
```r
docker container run --rm -it -v "$PWD":/app -p 8080:8080 webalmanacr
```r
r
3. Open http://localhost:8080 in your web browser to access the site. You can kill the server when it is no longer needed using `Ctrl+C`.r
r
4. Make changes in the code using any text editor and run tests (need to build the image again if any Python or Node dependencies are changed):r
r
```r
docker container run --rm -it -v "$PWD":/app webalmanac pytestr
```r
r
5. To avoid running commands in one-off mode run `bash` in a container (with necessary volumes mounted and ports mapped) then run successive commands:r
r
```r
docker container run --rm -it -v "$PWD":/app -v /app/node_modules -p 8080:8080 webalmanac bashr
root@[CID]:/app# pytestr
root@[CID]:/app# python main.pyr
^Cr
root@[CID]:/app# npm run generater
root@[CID]:/app# exitr
```r
r
6. To customize the image use `PYVER`, `NODEVER`, and `SKIPGC` build arguments to control which versions of Python and Node are used and whether Google Cloud SDK is installed.r
r
```r
docker image build --build-arg PYVER=3.7 --build-arg NODEVER=14.x --build-arg SKIPGC=false -t webalmanac:custom .r
```r
