# 1. Ensure you're not on the gh-pages branch
git checkout main  # Or your preferred branch

# 2. Delete the remote gh-pages branch
git push origin --delete gh-pages

# 3. Delete the local dist folder and recreate it (be careful with this!)
rm -rf dist
npm run build

# 4. Switch to a new branch (name it something unique)
git checkout -b dist-branch

# 5. Commit the new dist folder to this new branch
git add dist
git commit -m "Rebuilt website"

# 6. Push the new dist folder to a new gh-pages branch on the remote
git subtree push --prefix dist origin gh-pages

# 7. Switch back to your main branch
git checkout main

# 8. Delete the local branch you created earlier, we don't need it anymore
git branch -D dist-branch
