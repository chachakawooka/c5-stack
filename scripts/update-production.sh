#!/bin/bash
read -p "Have you run the export-files.sh script first? [Y/n] " -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]
then
    rm -rf production
    git clone $(git config remote.origin.url) production
    cd production

    git checkout production 2>/dev/null || git checkout --orphan production

    git rm -rf .
    cd ..
    rsync -av backup/app/ production/
    cd production
    rm .gitignore
    echo "application/files\napplication/config/generated" >> .gitignore
    git add .
    git commit -m 'Update production'
    git push --set-upstream origin production
    cd ..
    rm -rf production
fi
