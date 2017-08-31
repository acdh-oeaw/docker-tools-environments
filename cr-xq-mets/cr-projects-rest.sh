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
# docker-manage -e exist-curation-crxqmets-cur -a enter -c backup.sh -u "$USERNAME" -p "$PASSWORD" -r "/opt/exist/webapp/WEB-INF/data/$PROJECT.bak/db/apps/cr-xq-mets/__contents__.xml"
docker-manage -e exist-curation-crxqmets-cur -a enter -c backup.sh -u "$USERNAME" -p "$PASSWORD" -r "/opt/exist/webapp/WEB-INF/data/$PROJECT.bak/db/cr-projects/$PROJECT/__contents__.xml"
docker-manage -e exist-curation-crxqmets-cur -a enter -c backup.sh -u "$USERNAME" -p "$PASSWORD" -r "/opt/exist/webapp/WEB-INF/data/$PROJECT.bak/db/cr-data/$PROJECT/__contents__.xml"
docker-manage -e exist-curation-crxqmets-cur -a enter -c backup.sh -u "$USERNAME" -p "$PASSWORD" -r "/opt/exist/webapp/WEB-INF/data/$PROJECT.bak/db/system/config/db/cr-data/_workingcopies/$PROJECT/__contents__.xml"
docker-manage -e exist-curation-crxqmets-cur -a enter -c backup.sh -u "$USERNAME" -p "$PASSWORD" -r "/opt/exist/webapp/WEB-INF/data/$PROJECT.bak/db/cr-data/_workingcopies/$PROJECT/__contents__.xml"
docker-manage -e exist-curation-crxqmets-cur -a enter -c backup.sh -u "$USERNAME" -p "$PASSWORD" -r "/opt/exist/webapp/WEB-INF/data/$PROJECT.bak/db/cr-data/_lookuptables/$PROJECT/__contents__.xml"
docker-manage -e exist-curation-crxqmets-cur -a enter -c backup.sh -u "$USERNAME" -p "$PASSWORD" -r "/opt/exist/webapp/WEB-INF/data/$PROJECT.bak/db/cr-data/_resourcefragments/$PROJECT/__contents__.xml"
docker-manage -e exist-curation-crxqmets-cur -a enter -c backup.sh -u "$USERNAME" -p "$PASSWORD" -r "/opt/exist/webapp/WEB-INF/data/$PROJECT.bak/db/cr-data/_md/$PROJECT/__contents__.xml"
docker-manage -e exist-curation-crxqmets-cur -a enter -c backup.sh -u "$USERNAME" -p "$PASSWORD" -r "/opt/exist/webapp/WEB-INF/data/$PROJECT.bak/db/cr-data/_indexes/$PROJECT/__contents__.xml"