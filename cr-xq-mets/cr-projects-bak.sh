#!/bin/bash
echo -n 'Username for existdb (in dba group): '
read USERNAME
echo -n 'Passowrd:'
read -s PASSWORD
echo
if [ -z "$1" ]; then
  echo -n 'Project to back up: '
  read PROJECT;
else
  PROJECT="$1"
fi
mkdir -p "$HOME/data/$PROJECT.bak"
rm -rf "$HOME/data/$PROJECT.bak/*"
docker-manage -e exist-curation-crxqmets-cur -a enter -c backup.sh -u "$USERNAME" -p "$PASSWORD" -b /db/apps/cr-xq-mets -d "/opt/exist/webapp/WEB-INF/data/$PROJECT.bak"
docker-manage -e exist-curation-crxqmets-cur -a enter -c backup.sh -u "$USERNAME" -p "$PASSWORD" -b "/db/cr-projects/$PROJECT" -d "/opt/exist/webapp/WEB-INF/data/$PROJECT.bak"
docker-manage -e exist-curation-crxqmets-cur -a enter -c backup.sh -u "$USERNAME" -p "$PASSWORD" -b "/db/cr-data/$PROJECT" -d "/opt/exist/webapp/WEB-INF/data/$PROJECT.bak"
docker-manage -e exist-curation-crxqmets-cur -a enter -c backup.sh -u "$USERNAME" -p "$PASSWORD" -b "/db/cr-data/_workingcopies/$PROJECT" -d "/opt/exist/webapp/WEB-INF/data/$PROJECT.bak"
docker-manage -e exist-curation-crxqmets-cur -a enter -c backup.sh -u "$USERNAME" -p "$PASSWORD" -b "/db/cr-data/_lookuptables/$PROJECT" -d "/opt/exist/webapp/WEB-INF/data/$PROJECT.bak"
docker-manage -e exist-curation-crxqmets-cur -a enter -c backup.sh -u "$USERNAME" -p "$PASSWORD" -b "/db/cr-data/_resourcefragments/$PROJECT" -d "/opt/exist/webapp/WEB-INF/data/$PROJECT.bak"
docker-manage -e exist-curation-crxqmets-cur -a enter -c backup.sh -u "$USERNAME" -p "$PASSWORD" -b "/db/cr-data/_md/$PROJECT" -d "/opt/exist/webapp/WEB-INF/data/$PROJECT.bak"
docker-manage -e exist-curation-crxqmets-cur -a enter -c backup.sh -u "$USERNAME" -p "$PASSWORD" -b "/db/cr-data/_indexes/$PROJECT" -d "/opt/exist/webapp/WEB-INF/data/$PROJECT.bak"
docker-manage -e exist-curation-crxqmets-cur -a enter -c backup.sh -u "$USERNAME" -p "$PASSWORD" -b "/db/system/config/db/cr-data/_workingcopies/$PROJECT" -d "/opt/exist/webapp/WEB-INF/data/$PROJECT.bak"  
pushd "$HOME/data/$PROJECT.bak"
7za a -tzip "$HOME/$PROJECT.bak.zip" *
popd