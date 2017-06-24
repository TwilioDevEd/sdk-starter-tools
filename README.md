# Tools and Scripts for SDK Starter Kits

## Integration Tests for SDK Starter Kits

In the test directory, there is an integration test suite written in
Javascript using the Frisby v2 test framework. You can use this test
suite to test a running copy of any of the SDK Starter repos

Steps to install (from the test subdirectory)

`npm install`

This will install the dev dependencies.

If you would like to test the defaults (http://localhost:3000, not PHP), simply run

`npm test`

The test script uses two environment variables to determine the base URL for testing, and whether or not the starter kit is written in PHP (different route suffix)

baseUrl

testPHP

For instance, for Ruby, baseUrl might be http://localhost:4567

More tests can be added to the starter_spec.js source code file, and those tests can also be refined.

These are integration tests, and require Twilio credentials to run, which you would configure as you develop and test the SDK Starter Kits.

## Dockerfiles for SDK Starter Kits

Also under test are Dockerfiles for each of the SDK Starter Kits. These could be useful for testing environments that you don't have access to. Future plans for expansion would include different language versions (such as different versions of Node, Ruby, Python 2 vs Python 3). 

These Dockerfiles pull down the latest from the master repo, so they are more useful for testing as part of an ongoing process to make sure that nothing is broken, than during active development to implement a feature.

## Docker Compose - Integration Testing of SDK Starter Kits using Docker Compose

By combining the Docker files with an integration test for each SDK Starter Kit, we can run the integration tests against each of the SDK Starter Kits with one command

`docker-compose up`

As it stands now, all test output goes to the console, and it is a little jumbled in with the startup from each of the SDK Starter Kits. Future improvements could include some way to link this in with a test runner or report that shows an overall status for all builds. 

If this can be tied to a test runner, then this piece could also be built into continuous integration testing.



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
