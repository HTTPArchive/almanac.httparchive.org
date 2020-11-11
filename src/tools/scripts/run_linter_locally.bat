rem ######################################
rem ## Custom Web Almanac script        ##
rem ######################################
rem #
rem # Run the GitHub Super-Linter locally
rem # useful to avoid waiting on the push to get feed back
rem # 
rem # It can be run to lint everthing if no params are passed
rem # Or pass one or more params to just lint those files or folders
rem #

echo "Installing/Updating Linter (first time this can take a while)"
docker pull github/super-linter:latest

rem # Annoyingly super-linter includes node_modules and env which take a long time
rem # so let's copy to /tmp folder and lint from there

rem # Remove old files if they exist
rmdir /Q /S c:\temp\lint
mkdir c:\temp\lint

echo "Copying files to c:\temp\lint"
rem # Check if provided files on command line or linting all files
if [%1]==[] (
  echo "Copying all files"
  rem # Copy all the .github and src files
  mkdir c:\temp\lint\.github
  xcopy ..\.github c:\temp\lint\.github /E /I
  mkdir c:\temp\lint\src
  echo node_modules\ > c:\temp\lint\exclude.txt
  echo env\ >> c:\temp\lint\exclude.txt
  echo static\fonts\ >> c:\temp\lint\exclude.txt
  echo static\images\ >> c:\temp\lint\exclude.txt
  echo static\pdfs\ >> c:\temp\lint\exclude.txt
  echo __pycache__\ >> c:\temp\lint\exclude.txt
  xcopy * c:\temp\lint\src /EXCLUDE:c:\temp\lint\exclude.txt /E /I
  del c:\temp\lint\exclude.txt
) else (
  rem # Copy linter config files
  mkdir c:\temp\lint\.github
  mkdir c:\temp\lint\.github\linters
  xcopy ..\.github\linters c:\temp\lint\.github\linters  /E /I
  rem # Copy files provided
  for %%F in (%*) DO (
    echo "- Copying %%F"
    xcopy %%F c:\temp\lint\%%F  /E /I
  )
)

echo "Starting linting"
docker run -e RUN_LOCAL=true -e LOG_LEVEL=VERBOSE -e VALIDATE_BASH=true -e VALIDATE_CSS=true -e VALIDATE_HTML=true -e VALIDATE_JAVASCRIPT_ES=true -e VALIDATE_JSON=true -e VALIDATE_MD=true -e VALIDATE_PYTHON_PYLINT=true -e VALIDATE_PYTHON_FLAKE8=true -e VALIDATE_YAML=true -v "c:\temp\lint:/tmp/lint" github/super-linter
