## Getting Start.

- clone this project.
- bundle install --path=vendor/bundle
- npm install
- bower install
- ./node_modules/.bin/gulp serve

start browser and sample page up!

## For release
- First, exec commands in this dir.
  - Exec `bundle install` & `npm install` & `bower install`.
  - Exec `gulp build`, output modules in `dist` directory.
- Next, exec commands in Application Root Dir.
  - Exec `gulp --gulpfile=gulpfile_tea.coffee clean deploy`.
    - When copy template failed, each command `gulp --gulpfile=gulpfile_tea.coffee clean` and `gulp --gulpfile=gulpfile_tea.coffee clean deploy` execute in other processes.

### Build Shell for Local Development
```
#!/bin/sh
cd ${BIZEVO_ROOT}/spa/tea
bundle install --path=vendor/bundle
if [ $? -ne 0 ]; then exit 1; fi
npm install
if [ $? -ne 0 ]; then exit 1; fi
bower install
if [ $? -ne 0 ]; then exit 1; fi
gulp build
if [ $? -ne 0 ]; then exit 1; fi
cd ../../
bundle install --path=vendor/bundle
if [ $? -ne 0 ]; then exit 1; fi
npm install
if [ $? -ne 0 ]; then exit 1; fi
gulp bower
if [ $? -ne 0 ]; then exit 1; fi
gulp vendor
if [ $? -ne 0 ]; then exit 1; fi
gulp css
if [ $? -ne 0 ]; then exit 1; fi
gulp --gulpfile=gulpfile_tea.coffee clean
if [ $? -ne 0 ]; then exit 1; fi
gulp --gulpfile=gulpfile_tea.coffee deploy
if [ $? -ne 0 ]; then exit 1; fi

echo '------------------------'
echo 'ALL OVER'
echo '------------------------'
```
