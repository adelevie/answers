## Contributing

This project follows the [git flow](http://nvie.com/posts/a-successful-git-branching-model/) branching model of product development. The only difference is that our 'develop' branch is named [`dev`](https://github.com/18F/answers/tree/dev).

### Ruby

- [Style Guides](https://github.com/thoughtbot/guides#guides)

### Commit Messages

- Avoid merge commits by using a rebase workflow (see below for details).
- Prefix feature branch names with `feature`.
- Squash multiple trivial commits into a single commit (see below for details).
- Write a [good commit message](http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html).

## Submission Guidelines

### Submitting an Issue
Before you submit your issue search the archive, maybe your question was already answered.

If your issue appears to be a bug, and hasn't been reported, open a new issue.
Help us to maximize the effort we can spend fixing issues and adding new
features, by not reporting duplicate issues.  Providing the following information will increase the
chances of your issue being dealt with quickly:

* **Overview of the issue** - if an error is being thrown a non-minified stack trace helps
* **Motivation for or Use Case** - explain why this is a bug for you
* **Answers Version(s)** - is it a regression?
* **Browsers and Operating System** - is this a problem with all browsers or only IE8?
* **Reproduce the error** - provide a live example, screenshot, and/or a unambiguous set of steps. The more the better.
* **Related issues** - has a similar issue been reported before?  Reference the related issues in the descrioption.
* **Suggest a Fix** - if you can't fix the bug yourself, perhaps you can point to what might be
  causing the problem (line of code or commit).  If you're requesting a feature, describe how the feature might work to resolve the user story.

### Submitting a Pull Request
Before you submit your pull request consider the following guidelines:

* Search [GitHub](https://github.com/18f/answers/pulls) for an open or closed Pull Request that relates to your submission. You don't want to duplicate effort.
* Make your changes in a new git branch

     ```shell
     git checkout -b my-fix-branch dev
     ```

* Run the full rspec test suite, with `rake spec` and ensure that all tests pass.
* Commit your changes using a descriptive commit message.
* Rebase your feature branch with the dev branch frequently to make integration easier:

    ```
    git fetch origin
    git rebase origin/dev
    ```

  * If conflicts arise during the rebase, follow these steps until the rebase completes:
    1. Resolve conflicts in your editor/IDE
    2. `git add .`
    3. `git rebase --continue`

* When you have completed your feature development and are ready to submit a pull request, follow the following steps:
  1. Rebase your feature branch interactively to squash commits:
    
    ```shell
    git fetch origin
    git rebase -i origin/dev
    ```
  2. After the rebase has completed, a text editor will open listing all of your commits.  For every commit you want to squash, replace "pick" with "squash" or "s".  Note that you must leave at least one "pick" starting with the first line.
  3. Save and close the file.
  4. Another text editor should open.  Remove the commit messages you don't want and write one general message describing your work.  See [writing a good commit message](http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html) 
  5. Save and close the file.

* Push your branch to GitHub:

    ```shell
    git push origin my-fix-branch
    ```
* If the above command does not work, force the push:

    ```shell
    git push -f origin my-fix-branch
    ```

* In GitHub, send a pull request to `answers:dev`.
* If we suggest changes then:
  * Make the required updates.
  * Re-run the specs to ensure tests are still passing.
  * Rebase your branch and force push to your GitHub repository (this will update your Pull Request):

That's it! Thank you for your contribution!

#### After your pull request is merged

After your pull request is merged, you can safely delete your branch and pull the changes
from the main ([upstream](https://help.github.com/articles/configuring-a-remote-for-a-fork)) repository:

* Delete the remote branch on GitHub either through the GitHub web UI or your local shell as follows:

    ```shell
    git push origin --delete my-fix-branch
    ```

* Check out the dev branch:

    ```shell
    git checkout dev -f
    ```

* Delete the local branch:

    ```shell
    git branch -D my-fix-branch
    ```

* Update your dev with the latest upstream version:

    ```shell
    git pull --ff upstream dev
    ```


## MIT/Public Domain Joint Work

The project is a "joint work" (see 17 USC § 101) of the United States and
its original authors. It is partially copyrighted, partially public domain,
and as a whole is protected by the MIT copyright. Segments written by 18F
staff, and by contractors who are developing software on behalf of 18F are
also in the public domain, and copyright and related rights for that work
are waived through the [CC0 1.0 Universal public domain dedication][CC0].

All future contributions to this project will be released under the CC0
dedication (see LICENSE.md). By submitting a pull request, you are agreeing to comply
with this waiver of copyright interest.

[CC0]: http://creativecommons.org/publicdomain/zero/1.0/
