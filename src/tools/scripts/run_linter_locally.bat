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
if [ "$#" -gt 0 ]; then
  rem # Copy linter config files
  mkdir c:\temp\lint\.github
  copy -r ..\.github\linters c:\temp\lint\.github
  # Copy files provided
  for FILES in "$@"
  do
    echo "- Copying ${FILES}"
    copy -r "${FILES}" c:\temp\lint
  done
else
  echo "Copying all files"
  # Copy everything and then delete what you don't want linted
  # This is a really inefficient way of doing this but can't find a robust method
  # with MacOs and Linux support, without copying individual folders
  copy ..\.github c:\temp\lint
  copy ..\src c:\temp\lint
  rmdir /Q /S c:\temp\lint\src\node_modules
  rmdir /Q /S c:\temp\lint\src\env
  rmdir /Q /Sc:\temp\lint\src\static\fonts
  rmdir /Q /S c:\temp\lint\src\static\images
  rmdir /Q /S c:\temp\lint\src\static\pdfs
fi

echo "Starting linting"
docker run -e RUN_LOCAL=true -e VALIDATE_BASH=true -e VALIDATE_CSS=true -e VALIDATE_HTML=true -e VALIDATE_JAVASCRIPT_ES=true -e VALIDATE_JSON=true -e VALIDATE_MD=true -e VALIDATE_PYTHON_PYLINT=true -e VALIDATE_PYTHON_FLAKE8=true -e VALIDATE_YAML=true -v "c:\temp\lint:/tmp/lint" github/super-linter
