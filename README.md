# Tools and Scripts for SDK Starter Kits

## Merging Front End Web Changes for SDK Starter Kits for Web

All of the SDK Starter Kits for web share a common HTML/CSS/JS front end. This front end is static, and communicates with the back end server (written in [PHP](https://github.com/TwilioDevEd/sdk-starter-php)/[Python](https://github.com/TwilioDevEd/sdk-starter-python)/[Ruby](https://github.com/TwilioDevEd/sdk-starter-ruby)/[Node](https://github.com/TwilioDevEd/sdk-starter-node)/[Java](https://github.com/TwilioDevEd/sdk-starter-java)/[C#](https://github.com/TwilioDevEd/sdk-starter-csharp)) using AJAX.

Because we need to keep all of these front ends in sync, the `merge.rb` script will copy any front end changes from the [Node repository](https://github.com/TwilioDevEd/sdk-starter-node) into the other four repositories. In addition, it applies edits for the PHP Starter Kit, because the PHP AJAX URLs end in `.php`.

You will need to first develop your changes on the sdk-starter-node repository, and then merge them into master on that repo (through a pull request or through direct commits). Once you are satisfied with the state of the web front end on Node, you can use the merge script to apply your changes to the other four repos.

In addition to copying the changes, the merge script will also create a new branch in the repository (from master), and then create a commit and push the commit to the branch. The only manual steps left to do is to review the changes in the branch, test if needed on each repo, and then create a pull request on GitHub to merge the changes with master.

This merge script is only useful for working on changes on the master branch. In addition, it assumes that you have made the changes to the Node repository - if you are using Python, C#, Java, or Ruby, make that repository your front end repo in the merge script. PHP is a special case becauase of the AJAX URLs, so if you were working in that repo, you should backport your changes to Node and then merge from there.

To run the script, you will need commit access on the appropriate repositories.

The command line syntax is:

`ruby merge.rb branch-name 'Commit Message for the changes'`

The script will pull down all of the repos for you. You don't need local copies of the repos, but it could take some time over a slow connection.

Something didn't work just the way you wanted? Just delete the branches out of GitHub, and don't merge them to master.
