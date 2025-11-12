#! /bin/bash

# Script to automate taking the website down and rebuilding it
# I got too lazy to even run the like 4 commands this does (shout out automation)

# Make script terminate on error
set -e

# Pull GH
printf "Pulling readme-website/\n"
cd readme-website/
git checkout dev
git pull --ff-only origin dev
cd ..

# Rebuild the docker image
printf "Rebuilding Docker Image\n"
docker compose build
yes | docker image prune

# Bring the site down
printf "Bringing website down\n"
docker compose down

# Copy in DB and media
rm -rf media/
rm -f db.sqlite3
rsync -a ./prod-symlink/media/ ./media/
rsync -a ./prod-symlink/db.sqlite3 ./

# Bring site back up
printf "Bringing website up\n"
docker compose up -d

printf "Done\n"
