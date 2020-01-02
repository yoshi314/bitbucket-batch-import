# bitbucket-batch-import

A simple script to mass import local repositories to bitbucket

## Setup

Create the projects first in bitbucket manually

The script will scan directory ``projects`` and will expect a following setup :

- projects/projectAKey/repo_a
- projects/projectAKey/repo_b
- projects/projectAKey/repo_somethingelse
- projects/projectBKey/repo1
- projects/projectBKey/repo2
- projects/projectCKey/repo1
- projects/projectCKey/repo2

## Running

```bash
./import-repos.sh [username] [password] [team - optional]
```

## Output

The end result will be the following structure in BitBucket (in a form of urls) :

- bitbucket/projects/projectA/repos/repo_a
- bitbucket/projects/projectA/repos/repo_b
- bitbucket/projects/projectA/repos/repo_somethingelse

and so on.

The script will create a private repo, convert bare git repository into regular git format, add the bitbucket remote and push the commits. You will likely need as much disk space for import as the bare format repos use, unless you delete the work directory after each repository pass.

## Features

- Repository is created with a project
- Supports BARE or regular git workspaces
- Bitbucket 2.0 support
- Optional support for bitbucket teams

## Todo

- Allow teams to be optional
- Move defaults to .env
- Clean up the script
- get rid of external json file
