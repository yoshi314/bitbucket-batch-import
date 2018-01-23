# bitbucket-batch-import
A simple script to mass import repositories to bitbucket

# Setup

Add your BitBucket credentials to ~/.netrc and edit the import-repos.sh script to configure it

The script will scan directory projects and will expect a following setup : 

- projects/projectA/repo_a
- projects/projectA/repo_b
- projects/projectA/repo_somethingelse
- projects/projectB/repo1
- projects/projectB/repo2
- projects/projectC/repo1
- projects/projectC/repo2


# Limitations
Each repository is expected to be a --bare type git repo, usually produced by a tool akin to svn2git. This can of course be easily modified.

# Output
The end result will be the following structure in BitBucket (in a form of urls) :

- bitbucket/projects/project1/repos/repo_a
- bitbucket/projects/project1/repos/repo_b
- bitbucket/projects/project1/repos/repo_somethingelse 

and so on.

The script will setup a repo, checkout the bare git repository into regular git format, add the bitbucket remote and push the commits. You will likely need as much disk space for import as the bare format repos use, unless you delete the work directory after each repository pass.

# Todo

- Clean up the script
- get rid of external json file
- Support regular git checkouts directly
